extends Node2D

var npc = preload("res://scenes/npc.tscn")
@onready var spawn_door = $"../door"

func _on_timer_timeout() -> void:
	var npc_spawn = npc.instantiate()
	npc_spawn.position = spawn_door.position
	add_child(npc_spawn)
	
