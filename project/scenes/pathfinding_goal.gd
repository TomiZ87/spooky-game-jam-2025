extends Node2D

@onready var npc_box = get_tree().get_nodes_in_group("npc")
var picked_item
var picked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(global_position)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if picked:
		#queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "npc_hitbox":
		picked = true
