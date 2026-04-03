extends HBoxContainer
# Color selection UI for Brick Builder

signal color_selected(color_name)

var available_colors = ["Red", "Blue", "Green", "Yellow", "Black", "White", "Special"]
var color_buttons = {}
var current_color = "Red"

func _ready():
	create_color_buttons()
	select_color("Red")  # Default selection

func create_color_buttons():
	for color_name in available_colors:
		var button = Button.new()
		button.text = color_name
		button.custom_minimum_size = Vector2(60, 40)
		button.pressed.connect(_on_color_button_pressed.bind(color_name))
		
		# Set button color based on name
		match color_name:
			"Red":
				button.modulate = Color(1, 0.3, 0.3)
			"Blue":
				button.modulate = Color(0.3, 0.3, 1)
			"Green":
				button.modulate = Color(0.3, 1, 0.3)
			"Yellow":
				button.modulate = Color(1, 1, 0.3)
			"Black":
				button.modulate = Color(0.2, 0.2, 0.2)
			"White":
				button.modulate = Color(1, 1, 1)
			"Special":
				button.modulate = Color(1, 0.5, 1)  # Pink for special
		
		add_child(button)
		color_buttons[color_name] = button

func _on_color_button_pressed(color_name: String):
	select_color(color_name)
	color_selected.emit(color_name)

func select_color(color_name: String):
	# Deselect previous
	if current_color in color_buttons:
		color_buttons[current_color].flat = false
	
	# Select new
	current_color = color_name
	if color_name in color_buttons:
		color_buttons[color_name].flat = true
		color_buttons[color_name].modulate = color_buttons[color_name].modulate * 1.5  # Brighten
	
	print("Selected color: ", color_name)

func get_current_color():
	return current_color