extends HBoxContainer
# Brick type selection UI

signal brick_selected(brick_name)

var available_bricks = []
var brick_buttons = {}
var current_brick = "brick_low_1"

func _ready():
	# Discover available brick types
	discover_brick_types()
	create_brick_buttons()
	select_brick("brick_low_1")  # Default selection

func discover_brick_types():
	# Look in Red folder for brick types (all colors have same types)
	var dir = DirAccess.open("res://assets/bricks/Red/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				var brick_name = file_name.replace(".png", "")
				available_bricks.append(brick_name)
			file_name = dir.get_next()
	
	# Sort for consistent order
	available_bricks.sort()
	print("Discovered %d brick types" % available_bricks.size())

func create_brick_buttons():
	# Create buttons for first few brick types (can scroll if needed)
	var max_buttons = min(8, available_bricks.size())
	
	for i in range(max_buttons):
		var brick_name = available_bricks[i]
		var button = Button.new()
		
		# Short display name
		var display_name = brick_name.replace("brick_", "").replace("_", " ")
		button.text = display_name
		button.custom_minimum_size = Vector2(80, 40)
		button.pressed.connect(_on_brick_button_pressed.bind(brick_name))
		
		# Tooltip with full name
		button.tooltip_text = brick_name
		
		add_child(button)
		brick_buttons[brick_name] = button

func _on_brick_button_pressed(brick_name: String):
	select_brick(brick_name)
	brick_selected.emit(brick_name)

func select_brick(brick_name: String):
	# Deselect previous
	if current_brick in brick_buttons:
		brick_buttons[current_brick].flat = false
	
	# Select new
	current_brick = brick_name
	if brick_name in brick_buttons:
		brick_buttons[brick_name].flat = true
		brick_buttons[brick_name].modulate = Color(1.2, 1.2, 1.2)  # Brighten
	
	print("Selected brick: ", brick_name)

func get_current_brick():
	return current_brick