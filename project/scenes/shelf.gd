extends Area2D

signal interacted

func _ready():
	# Make sure input pickable is enabled
	input_pickable = true
	# Ensure the area can receive mouse input
	set_process_input(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		interact()

func interact():
	print("Area clicked! Interaction triggered.")
	emit_signal("interacted")
