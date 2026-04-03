extends Node2D

@onready var build_area = $BuildArea
@onready var clear_button = $UI/ClearButton
@onready var rotate_button = $UI/RotateButton
@onready var color_selector = $UI/ColorSelector
@onready var brick_selector = $UI/BrickSelector
@onready var drag_system = $DragDropSystem
@onready var touch_input = $TouchInput

# Screen boundaries
var screen_width = 1280
var screen_height = 720
var floor_y = 650  # Position of the floor

# Current selection
var current_color = "Red"
var current_brick_type = "brick_low_1"

func _ready():
	print("Brick Builder Sandbox - Godot 4.6")
	print("Ready to build!")
	
	# Connect signals
	clear_button.pressed.connect(_on_clear_button_pressed)
	rotate_button.pressed.connect(_on_rotate_button_pressed)
	color_selector.color_selected.connect(_on_color_selected)
	brick_selector.brick_selected.connect(_on_brick_selected)
	
	# Create invisible physics floor and boundaries
	create_floor()
	create_boundaries()
	
	# Place test bricks
	place_test_bricks()
	
	print("Test bricks placed on floor!")

func _input(event):
	# Try touch input first (for mobile)
	if touch_input.process_touch_event(event, drag_system, current_color, current_brick_type, place_brick):
		# Touch event was handled
		return
	
	# Handle mouse input for drag & drop (desktop)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start drag
				drag_system.start_drag(current_color, current_brick_type, event.position)
			else:
				# End drag - place brick
				var final_position = drag_system.end_drag(event.position)
				if final_position:
					place_brick(final_position, current_color, current_brick_type)
		
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			# Right-click to rotate ghost brick
			if drag_system.is_dragging_active():
				drag_system.rotate_ghost()
	
	elif event is InputEventMouseMotion:
		# Update drag position
		if drag_system.is_dragging_active():
			drag_system.update_drag(event.position)
	
	elif event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			# Cancel drag
			drag_system.cancel_drag()
		elif event.keycode == KEY_R:
			# R key to rotate ghost brick
			if drag_system.is_dragging_active():
				drag_system.rotate_ghost()

func _on_clear_button_pressed():
	# Remove all bricks (but keep floor and boundaries)
	for child in build_area.get_children():
		if child is RigidBody2D and child.name != "Floor" and child.name != "LeftWall" and child.name != "RightWall":
			child.queue_free()
	print("All bricks cleared!")

func _on_color_selected(color_name: String):
	current_color = color_name
	print("Current color: ", current_color)

func _on_brick_selected(brick_name: String):
	current_brick_type = brick_name
	print("Current brick type: ", current_brick_type)

func _on_rotate_button_pressed():
	# Rotate ghost brick if dragging
	if drag_system.is_dragging_active():
		drag_system.rotate_ghost()

func place_brick(position: Vector2, color: String, brick_type: String):
	# Clamp to screen boundaries
	var spawn_x = clamp(position.x, 50, screen_width - 50)
	var spawn_y = clamp(position.y, 50, floor_y - 50)
	
	var brick_scene = load("res://Brick.tscn")
	var brick = brick_scene.instantiate()
	brick.position = Vector2(spawn_x, spawn_y)
	
	# Build texture path
	var texture_path = "res://assets/bricks/%s/%s.png" % [color, brick_type]
	brick.set_texture(texture_path)
	
	# Apply rotation from drag system
	var rotation_angle = drag_system.get_ghost_rotation()
	brick.set_rotation_angle(rotation_angle)
	
	build_area.add_child(brick)
	
	print("Placed %s %s at %s (rotation: %s°)" % [color, brick_type, brick.position, rotation_angle])

func place_test_bricks():
	# Place a few test bricks in different colors
	var colors = ["Red", "Blue", "Green", "Yellow"]
	var brick_types = ["brick_low_1", "brick_medium_2", "brick_high_4", "brick_low_slope_left_1"]
	var x_positions = [300, 400, 500, 600]
	
	for i in range(4):
		place_brick(
			Vector2(x_positions[i], floor_y - 50 - (i * 80)),
			colors[i],
			brick_types[i]
		)

func create_floor():
	# Create a static floor for bricks to land on
	var floor = StaticBody2D.new()
	floor.name = "Floor"
	
	var floor_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(screen_width, 20)
	floor_shape.shape = shape
	floor_shape.position = Vector2(screen_width / 2, floor_y + 10)
	
	floor.add_child(floor_shape)
	build_area.add_child(floor)
	
	print("Floor created at y=", floor_y)

func create_boundaries():
	# Create left wall
	var left_wall = StaticBody2D.new()
	left_wall.name = "LeftWall"
	
	var left_shape = CollisionShape2D.new()
	var left_rect = RectangleShape2D.new()
	left_rect.size = Vector2(20, screen_height)
	left_shape.shape = left_rect
	left_shape.position = Vector2(-10, screen_height / 2)
	
	left_wall.add_child(left_shape)
	build_area.add_child(left_wall)
	
	# Create right wall
	var right_wall = StaticBody2D.new()
	right_wall.name = "RightWall"
	
	var right_shape = CollisionShape2D.new()
	var right_rect = RectangleShape2D.new()
	right_rect.size = Vector2(20, screen_height)
	right_shape.shape = right_rect
	right_shape.position = Vector2(screen_width + 10, screen_height / 2)
	
	right_wall.add_child(right_shape)
	build_area.add_child(right_wall)
	
	print("Side boundaries created")