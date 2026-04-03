extends RigidBody2D

var rotation_angle = 0  # Current rotation in degrees
var rotation_increment = 90  # Rotate by 90 degrees each time

func _ready():
	# Setup physics
	gravity_scale = 1.0
	linear_damp = 0.1
	angular_damp = 0.1
	can_sleep = true
	
	# Start with zero velocity (won't immediately fall)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

func set_texture(texture_path: String):
	var texture = load(texture_path)
	if texture:
		$Sprite2D.texture = texture
		
		# Create collision shape matching texture size
		var shape = RectangleShape2D.new()
		shape.size = texture.get_size()
		$CollisionShape2D.shape = shape
		
		# Center the collision shape
		$CollisionShape2D.position = texture.get_size() / 2

func rotate_brick():
	# Rotate by 90 degrees
	rotation_angle = fmod(rotation_angle + rotation_increment, 360)
	rotation_degrees = rotation_angle
	
	# Also rotate collision shape
	$CollisionShape2D.rotation_degrees = rotation_angle
	
	print("Brick rotated to ", rotation_angle, " degrees")
	
	# Visual feedback
	highlight()

func set_rotation_angle(angle: float):
	# Set specific rotation angle
	rotation_angle = fmod(angle, 360)
	rotation_degrees = rotation_angle
	$CollisionShape2D.rotation_degrees = rotation_angle

# Optional: Add a small visual effect when brick is placed or rotated
func highlight():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1.5, 1.5, 1.5, 1), 0.1)
	tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 1), 0.2)

func get_rotation_angle():
	return rotation_angle