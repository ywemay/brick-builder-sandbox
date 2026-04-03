extends Node2D

# UI references
@onready var build_area = $BuildArea
@onready var clear_button = $UI/ClearButton
@onready var rotate_button = $UI/RotateButton
@onready var color_selector = $UI/ColorSelector
@onready var brick_selector = $UI/BrickSelectorPanel/BrickSelector
@onready var drag_system = $DragDropSystem
@onready var touch_input = $TouchInput

# Screen boundaries
var screen_width = 1280
var screen_height = 720
var floor_y = 650  # Position of the floor

# Game state
var current_color = "Red"
var current_brick_type = "brick_low_1"
var bricks = []  # Array of placed bricks
var selected_brick = null  # Brick currently being moved
var is_moving_brick = false

func _ready():
	print("Brick Builder Sandbox - Godot 4.6 - Kid Friendly Edition")
	print("🎮 Pick color, pick brick, drag to build!")
	print("💥 Right-click brick to explode")
	
	# Connect signals
	clear_button.pressed.connect(_on_clear_button_pressed)
	rotate_button.pressed.connect(_on_rotate_button_pressed)
	color_selector.color_selected.connect(_on_color_selected)
	brick_selector.brick_selected.connect(_on_brick_selected)
	
	# Update brick selector when color changes
	color_selector.color_selected.connect(_on_color_changed_for_bricks)
	
	# Create invisible physics floor and boundaries
	create_floor()
	create_boundaries()
	
	# Place test bricks
	place_test_bricks()
	
	print("Test bricks placed on floor!")

func _input(event):
	# Try touch input first (for mobile)
	if touch_input.process_touch_event(event, self, drag_system, current_color, current_brick_type, place_brick):
		# Touch event was handled
		return
	
	# Handle mouse input for drag & drop (desktop)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Check if clicking on existing brick
				var clicked_brick = get_brick_at_position(event.position)
				if clicked_brick:
					# Start moving existing brick instead of placing new one
					start_moving_brick(clicked_brick, event.position)
					return
				
				# Otherwise start drag for new brick
				drag_system.start_drag(current_color, current_brick_type, event.position)
			else:
				# Mouse button released
				if is_moving_brick and selected_brick:
					# Finish moving brick
					finish_moving_brick(event.position)
				else:
					# Place new brick
					var final_position = drag_system.end_drag(event.position)
					if final_position:
						place_brick(final_position, current_color, current_brick_type)
		
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			# Check if right-clicking on a brick
			var clicked_brick = get_brick_at_position(event.position)
			if clicked_brick:
				# Explode the brick!
				explode_brick(clicked_brick)
			else:
				# Rotate ghost brick while dragging
				drag_system.rotate_ghost()
		
		elif event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			# Middle click to cancel
			if is_moving_brick:
				cancel_moving_brick()
			else:
				drag_system.cancel_drag()
	
	elif event is InputEventMouseMotion:
		if is_moving_brick and selected_brick:
			# Update position of brick being moved
			update_moving_brick(event.position)
		else:
			# Update drag position
			drag_system.update_drag(event.position)
	
	elif event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				# Cancel current operation
				if is_moving_brick:
					cancel_moving_brick()
				else:
					drag_system.cancel_drag()
			elif event.keycode == KEY_R:
				# Rotate
				if is_moving_brick and selected_brick:
					rotate_selected_brick()
				else:
					drag_system.rotate_ghost()

# ===== BRICK MOVEMENT FUNCTIONS =====

func get_brick_at_position(position: Vector2):
	# Check if position hits any brick
	for brick in bricks:
		if brick and brick.has_method("contains_point"):
			if brick.contains_point(position):
				return brick
	return null

func start_moving_brick(brick, start_position: Vector2):
	selected_brick = brick
	is_moving_brick = true
	
	# Highlight the brick
	if brick.has_method("highlight"):
		brick.highlight(true)
	
	# Store original position in case we cancel
	# position is a property of Node2D, accessible directly
	brick.original_position = brick.position
	
	print("Moving brick: ", brick.name)

func update_moving_brick(position: Vector2):
	if not selected_brick:
		return
	
	# Snap to grid (64px)
	var grid_size = 64
	var snapped_x = round(position.x / grid_size) * grid_size
	var snapped_y = round(position.y / grid_size) * grid_size
	
	# Update brick position
	selected_brick.position = Vector2(snapped_x, snapped_y)

func finish_moving_brick(final_position: Vector2):
	if not selected_brick:
		return
	
	# Snap to final grid position
	var grid_size = 64
	var snapped_x = round(final_position.x / grid_size) * grid_size
	var snapped_y = round(final_position.y / grid_size) * grid_size
	
	selected_brick.position = Vector2(snapped_x, snapped_y)
	
	# Remove highlight
	if selected_brick.has_method("highlight"):
		selected_brick.highlight(false)
	
	print("Brick moved to: ", selected_brick.position)
	
	# Reset state
	is_moving_brick = false
	selected_brick = null

func cancel_moving_brick():
	if not selected_brick:
		return
	
	# Return to original position
	# We set original_position in start_moving_brick, so it should exist
	# Use a safe approach in case it doesn't
	var original_pos = selected_brick.get("original_position")
	if original_pos:
		selected_brick.position = original_pos
	
	# Remove highlight
	if selected_brick.has_method("highlight"):
		selected_brick.highlight(false)
	
	print("Brick move cancelled")
	
	# Reset state
	is_moving_brick = false
	selected_brick = null

func rotate_selected_brick():
	if not selected_brick:
		return
	
	if selected_brick.has_method("rotate_brick"):
		selected_brick.rotate_brick()
		print("Brick rotated")

func explode_brick(brick):
	if not brick:
		return
	
	print("💥 Exploding brick: ", brick.name)
	
	# Create explosion effect
	var explosion_scene = load("res://ExplosionEffect.gd")
	if explosion_scene:
		var explosion = explosion_scene.new()
		explosion.position = brick.position
		add_child(explosion)
		
		# Set explosion color based on brick color
		if explosion.has_method("set_explosion_color"):
			var brick_color = brick.modulate
			explosion.set_explosion_color(brick_color)
	
	# Visual feedback on brick
	brick.modulate = Color(1.0, 0.3, 0.3)  # Red tint
	brick.scale = Vector2(1.3, 1.3)  # Slightly larger
	
	# Create a timer to remove the brick
	var timer = get_tree().create_timer(0.3)
	timer.timeout.connect(_on_explosion_timer_timeout.bind(brick))
	
	# Play explosion sound (if implemented)
	# play_explosion_sound()

func _on_explosion_timer_timeout(brick):
	if brick and is_instance_valid(brick):
		# Remove from array
		var index = bricks.find(brick)
		if index != -1:
			bricks.remove_at(index)
		
		# Remove from scene
		brick.queue_free()
		print("Brick exploded and removed!")

# ===== BRICK PLACEMENT FUNCTIONS =====

func place_brick(position: Vector2, color: String, brick_type: String):
	# Load brick scene
	var brick_scene = load("res://Brick.tscn")
	if not brick_scene:
		print("Error: Could not load Brick.tscn")
		return
	
	# Create brick instance
	var brick = brick_scene.instantiate()
	if not brick:
		print("Error: Could not instantiate brick")
		return
	
	# Set brick properties
	brick.name = "Brick_%d" % bricks.size()
	
	# Set position (snapped to grid)
	var grid_size = 64
	var snapped_x = round(position.x / grid_size) * grid_size
	var snapped_y = round(position.y / grid_size) * grid_size
	brick.position = Vector2(snapped_x, snapped_y)
	
	# Set texture based on color and type
	var texture_path = "res://assets/bricks/%s/%s.png" % [color, brick_type]
	var texture = load(texture_path)
	if texture and brick.has_method("set_texture"):
		brick.set_texture(texture)
	else:
		print("Warning: Could not load texture: ", texture_path)
	
	# Add to build area
	build_area.add_child(brick)
	bricks.append(brick)
	
	print("Placed brick: ", brick_type, " at ", brick.position)

# ===== TEST BRICKS =====

func place_test_bricks():
	# Place a few test bricks in different colors
	var test_positions = [
		Vector2(200, floor_y - 64),  # Red
		Vector2(300, floor_y - 64),  # Blue
		Vector2(400, floor_y - 64),  # Green
		Vector2(500, floor_y - 64),  # Yellow
	]
	
	var test_colors = ["Red", "Blue", "Green", "Yellow"]
	var test_brick = "brick_low_1"
	
	for i in range(test_positions.size()):
		if i < test_colors.size():
			place_brick(test_positions[i], test_colors[i], test_brick)

# ===== PHYSICS FUNCTIONS =====

func create_floor():
	# Create invisible floor for physics
	var floor_body = StaticBody2D.new()
	floor_body.name = "PhysicsFloor"
	
	var floor_collision = CollisionShape2D.new()
	var floor_shape = RectangleShape2D.new()
	floor_shape.size = Vector2(screen_width, 10)
	floor_collision.shape = floor_shape
	floor_collision.position = Vector2(screen_width / 2, floor_y + 5)
	
	floor_body.add_child(floor_collision)
	add_child(floor_body)
	
	print("Created physics floor at y=", floor_y)

func create_boundaries():
	# Create left boundary
	var left_wall = StaticBody2D.new()
	left_wall.name = "LeftWall"
	
	var left_collision = CollisionShape2D.new()
	var left_shape = RectangleShape2D.new()
	left_shape.size = Vector2(10, screen_height)
	left_collision.shape = left_shape
	left_collision.position = Vector2(-5, screen_height / 2)
	
	left_wall.add_child(left_collision)
	add_child(left_wall)
	
	# Create right boundary
	var right_wall = StaticBody2D.new()
	right_wall.name = "RightWall"
	
	var right_collision = CollisionShape2D.new()
	var right_shape = RectangleShape2D.new()
	right_shape.size = Vector2(10, screen_height)
	right_collision.shape = right_shape
	right_collision.position = Vector2(screen_width + 5, screen_height / 2)
	
	right_wall.add_child(right_collision)
	add_child(right_wall)
	
	print("Created side boundaries")

# ===== UI CALLBACKS =====

func _on_clear_button_pressed():
	print("Clearing all bricks!")
	
	# Remove all bricks
	for brick in bricks:
		if brick and is_instance_valid(brick):
			brick.queue_free()
	
	bricks.clear()
	
	# Cancel any ongoing operations
	if is_moving_brick:
		cancel_moving_brick()
	else:
		drag_system.cancel_drag()
	
	print("All bricks cleared!")

func _on_rotate_button_pressed():
	# Rotate ghost brick if dragging
	if drag_system.is_dragging_active():
		drag_system.rotate_ghost()
	elif is_moving_brick and selected_brick:
		rotate_selected_brick()

func _on_color_selected(color: String):
	current_color = color
	print("Selected color: ", color)

func _on_brick_selected(brick_name: String):
	current_brick_type = brick_name
	print("Selected brick type: ", brick_name)

func _on_color_changed_for_bricks(color: String):
	# Update brick selector to show bricks of new color
	if brick_selector and brick_selector.has_method("set_color"):
		brick_selector.set_color(color)
	
	# Also update current color
	current_color = color
	print("Brick selector updated for color: ", color)