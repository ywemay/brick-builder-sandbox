extends Node
# Enhanced touch input for mobile devices

var touch_start_positions = {}  # Dictionary: touch_index -> start_position
var is_touch_device = false

func _ready():
	# Check if running on touch device
	is_touch_device = DisplayServer.is_touchscreen_available()
	print("Touch device: ", is_touch_device)

func process_touch_event(event, main_node, drag_system, current_color, current_brick_type, place_brick_callback):
	if not is_touch_device:
		return false
	
	if event is InputEventScreenTouch:
		var touch_index = event.index
		
		if event.pressed:
			# Touch started
			touch_start_positions[touch_index] = event.position
			
			# Check if touching existing brick
			if main_node and main_node.has_method("get_brick_at_position"):
				var clicked_brick = main_node.get_brick_at_position(event.position)
				if clicked_brick:
					# Start moving existing brick
					if main_node.has_method("start_moving_brick"):
						main_node.start_moving_brick(clicked_brick, event.position)
					return true
			
			# Otherwise start drag for new brick
			drag_system.start_drag(current_color, current_brick_type, event.position)
			return true
		else:
			# Touch ended
			if touch_index in touch_start_positions:
				# Check if we were moving a brick
				if main_node and main_node.has_method("is_moving_brick") and main_node.is_moving_brick:
					# Finish moving brick
					if main_node.has_method("finish_moving_brick"):
						main_node.finish_moving_brick(event.position)
				else:
					# End drag and place brick
					var final_position = drag_system.end_drag(event.position)
					if final_position:
						# Call the callback to place the actual brick
						place_brick_callback.call(final_position, current_color, current_brick_type)
				
				# Clean up
				touch_start_positions.erase(touch_index)
				return true
	
	elif event is InputEventScreenDrag:
		var touch_index = event.index
		
		if touch_index in touch_start_positions:
			# Check if we're moving a brick
			if main_node and main_node.has_method("is_moving_brick") and main_node.is_moving_brick:
				# Update position of brick being moved
				if main_node.has_method("update_moving_brick"):
					main_node.update_moving_brick(event.position)
			else:
				# Update drag position
				drag_system.update_drag(event.position)
			return true
	
	return false

func is_touch_available():
	return is_touch_device

# Simple rotation for touch - double tap or separate button would be better
func handle_touch_rotation(event, drag_system):
	if not is_touch_device:
		return false
	
	if event is InputEventScreenTouch and event.pressed:
		# For now, we'll use a separate rotation button in UI
		# In a full implementation, could use two-finger gesture or double-tap
		pass
	
	return false