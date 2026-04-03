extends HBoxContainer
# Visual color selector with color swatches for kids

signal color_selected(color: String)

var color_buttons = {}
var selected_button = null

# Color definitions with kid-friendly names
var colors = {
	"Red": Color(1.0, 0.2, 0.2),
	"Blue": Color(0.2, 0.4, 1.0),
	"Green": Color(0.2, 0.8, 0.2),
	"Yellow": Color(1.0, 0.9, 0.2),
	"Black": Color(0.1, 0.1, 0.1),
	"White": Color(0.95, 0.95, 0.95),
	"Special": Color(0.8, 0.4, 1.0)  # Purple for special
}

func _ready():
	create_color_buttons()

func create_color_buttons():
	for color_name in colors.keys():
		var button = Button.new()
		button.custom_minimum_size = Vector2(48, 48)
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		
		# Set button color
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = colors[color_name]
		stylebox.corner_radius_top_left = 8
		stylebox.corner_radius_top_right = 8
		stylebox.corner_radius_bottom_right = 8
		stylebox.corner_radius_bottom_left = 8
		
		# Add border for selected state
		var selected_stylebox = stylebox.duplicate()
		selected_stylebox.border_color = Color(1.0, 1.0, 1.0)
		selected_stylebox.border_width_left = 3
		selected_stylebox.border_width_top = 3
		selected_stylebox.border_width_right = 3
		selected_stylebox.border_width_bottom = 3
		
		button.add_theme_stylebox_override("normal", stylebox)
		button.add_theme_stylebox_override("pressed", selected_stylebox)
		button.add_theme_stylebox_override("hover", stylebox)
		
		# Tooltip for accessibility
		button.tooltip_text = color_name
		
		button.pressed.connect(_on_color_button_pressed.bind(button, color_name))
		
		add_child(button)
		color_buttons[color_name] = button
	
	# Select Red by default
	select_color("Red")

func _on_color_button_pressed(button: Button, color_name: String):
	# Deselect previous button
	if selected_button and selected_button != button:
		selected_button.button_pressed = false
	
	# Select new button
	selected_button = button
	color_selected.emit(color_name)
	
	# Visual feedback
	button.modulate = Color(1.2, 1.2, 1.2)  # Brighten

func select_color(color_name: String):
	if color_name in color_buttons:
		var button = color_buttons[color_name]
		button.button_pressed = true
		_on_color_button_pressed(button, color_name)

func get_selected_color() -> String:
	if selected_button:
		for color_name in color_buttons:
			if color_buttons[color_name] == selected_button:
				return color_name
	return "Red"