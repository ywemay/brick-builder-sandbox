extends ScrollContainer
# Visual brick selector with actual brick images for kids

signal brick_selected(brick_name: String)

var current_color = "Red"
var brick_buttons = {}  # Dictionary: button -> brick_name
var selected_button = null

var grid_container = null

func _ready():
	# Get the GridContainer
	grid_container = get_node("GridContainer")
	if not grid_container:
		print("ERROR: GridContainer not found!")
		return
	
	# Create initial buttons for current color
	refresh_bricks()

func set_color(color: String):
	current_color = color
	refresh_bricks()

func refresh_bricks():
	# Check if grid_container exists
	if not grid_container:
		print("ERROR: grid_container is null in refresh_bricks()")
		return
	
	# Clear existing buttons
	for button in brick_buttons.keys():
		button.queue_free()
	brick_buttons.clear()
	selected_button = null
	
	# Get all brick textures for current color
	var brick_dir = "res://assets/bricks/%s/" % current_color
	var dir = DirAccess.open(brick_dir)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.ends_with(".png"):
				var brick_name = file.get_basename()
				create_brick_button(brick_name, brick_dir + file)

func create_brick_button(brick_name: String, texture_path: String):
	var button = Button.new()
	button.custom_minimum_size = Vector2(80, 80)  # Larger for kids
	button.toggle_mode = true
	button.focus_mode = Control.FOCUS_NONE
	
	# Load texture
	var texture = load(texture_path)
	if texture:
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size = Vector2(64, 64)  # Larger image
		button.add_child(texture_rect)
	
	button.pressed.connect(_on_brick_button_pressed.bind(button, brick_name))
	
	# Check if grid_container exists before adding child
	if grid_container:
		grid_container.add_child(button)
		brick_buttons[button] = brick_name
	else:
		print("ERROR: grid_container is null in create_brick_button()")
	
	# Select first brick by default
	if brick_buttons.size() == 1:
		button.button_pressed = true
		_on_brick_button_pressed(button, brick_name)
	
	return button

func _on_brick_button_pressed(button: Button, brick_name: String):
	# Deselect previous button
	if selected_button and selected_button != button:
		selected_button.button_pressed = false
		selected_button.modulate = Color(1.0, 1.0, 1.0)  # Reset color
	
	# Select new button
	selected_button = button
	brick_selected.emit(brick_name)
	
	# Visual feedback
	button.modulate = Color(0.8, 1.0, 0.8)  # Light green tint

func get_selected_brick() -> String:
	if selected_button and selected_button in brick_buttons:
		return brick_buttons[selected_button]
	# Return default if nothing selected
	return "brick_low_1"