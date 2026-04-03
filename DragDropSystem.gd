extends Node
# Drag and drop system for Brick Builder

signal brick_placed(position, color, brick_type)

var is_dragging = false
var drag_brick = null
var ghost_brick = null
var grid_size = 64  # Snap to 64px grid
var ghost_rotation = 0  # Current rotation of ghost brick

func _ready():
	print("Drag & Drop system ready")

func start_drag(color: String, brick_type: String, start_position: Vector2):
	# Reset rotation for new drag
	ghost_rotation = 0
	
	# Create a ghost brick for preview
	var brick_scene = load("res://Brick.tscn")
	ghost_brick = brick_scene.instantiate()
	
	# Set ghost appearance (semi-transparent)
	var texture_path = "res://assets/bricks/%s/%s.png" % [color, brick_type]
	ghost_brick.set_texture(texture_path)
	ghost_brick.modulate = Color(1, 1, 1, 0.5)
	
	# Disable physics on ghost
	ghost_brick.gravity_scale = 0
	ghost_brick.freeze = true
	
	# Position at mouse
	ghost_brick.position = snap_to_grid(start_position)
	ghost_brick.set_rotation_angle(ghost_rotation)
	
	# Add to scene
	get_parent().add_child(ghost_brick)
	
	is_dragging = true
	print("Started dragging %s %s" % [color, brick_type])

func update_drag(position: Vector2):
	if is_dragging and ghost_brick:
		ghost_brick.position = snap_to_grid(position)

func rotate_ghost():
	if is_dragging and ghost_brick:
		ghost_rotation = fmod(ghost_rotation + 90, 360)
		ghost_brick.set_rotation_angle(ghost_rotation)
		print("Ghost rotated to ", ghost_rotation, " degrees")

func end_drag(position: Vector2):
	if is_dragging and ghost_brick:
		var final_position = snap_to_grid(position)
		
		# Remove ghost
		ghost_brick.queue_free()
		ghost_brick = null
		
		is_dragging = false
		
		# Emit signal for actual brick placement
		# (The actual brick will be created by Main.gd)
		return final_position
	
	return position

func cancel_drag():
	if is_dragging and ghost_brick:
		ghost_brick.queue_free()
		ghost_brick = null
		is_dragging = false
		print("Drag cancelled")

func snap_to_grid(position: Vector2) -> Vector2:
	# Snap to nearest grid point
	var snapped_x = round(position.x / grid_size) * grid_size
	var snapped_y = round(position.y / grid_size) * grid_size
	return Vector2(snapped_x, snapped_y)

func is_dragging_active():
	return is_dragging

func get_ghost_rotation():
	return ghost_rotation

func reset_rotation():
	ghost_rotation = 0