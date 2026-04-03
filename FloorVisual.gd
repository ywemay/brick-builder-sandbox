extends Node2D
# Simple visual indicator for the floor

func _ready():
	# Create a visible floor line
	var line = Line2D.new()
	line.width = 3
	line.default_color = Color(0.3, 0.3, 0.3, 0.5)
	line.points = PackedVector2Array([
		Vector2(0, 650),
		Vector2(1280, 650)
	])
	add_child(line)
	
	# Add a label
	var label = Label.new()
	label.text = "FLOOR"
	label.position = Vector2(10, 630)
	label.modulate = Color(0.5, 0.5, 0.5, 0.7)
	add_child(label)