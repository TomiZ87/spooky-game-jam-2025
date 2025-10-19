extends Area2D
#npc_hitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pickup(area: Area2D) -> void:
	get_parent().picked_up = area.get_parent()
