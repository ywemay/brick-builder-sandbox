extends CPUParticles2D
# Simple explosion effect for brick destruction

func _ready():
	# Configure explosion particles
	emitting = true
	one_shot = true
	amount = 20
	lifetime = 0.5
	explosiveness = 1.0
	gravity = Vector2(0, 98)
	
	# Random direction
	initial_velocity = 100
	initial_velocity_random = 0.5
	angular_velocity = 180
	angular_velocity_random = 1.0
	
	# Color (red/orange explosion)
	color = Color(1.0, 0.5, 0.2)
	color_ramp = create_color_ramp()
	
	# Scale
	scale_amount = 2.0
	scale_amount_random = 0.5
	
	# Auto-remove after explosion
	var timer = get_tree().create_timer(lifetime + 0.1)
	timer.timeout.connect(Callable(self.queue_free))

func create_color_ramp() -> Gradient:
	var gradient = Gradient.new()
	gradient.set_color(0, Color(1.0, 1.0, 0.2))  # Yellow start
	gradient.set_color(0.3, Color(1.0, 0.5, 0.2))  # Orange middle
	gradient.set_color(0.7, Color(0.8, 0.2, 0.1))  # Red end
	gradient.set_color(1.0, Color(0.5, 0.1, 0.0, 0.0))  # Fade out
	return gradient

func set_explosion_color(base_color: Color):
	# Adjust explosion color based on brick color
	color = base_color.lightened(0.3)
	
	var gradient = Gradient.new()
	gradient.set_color(0, base_color.lightened(0.5))
	gradient.set_color(0.5, base_color)
	gradient.set_color(1.0, base_color.darkened(0.3))
	color_ramp = gradient