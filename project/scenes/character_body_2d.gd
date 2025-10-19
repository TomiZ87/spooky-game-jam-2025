extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var chest = get_tree().get_first_node_in_group("chest_area")
@onready var path_box = get_tree().get_first_node_in_group("pathfind_placeholder")
@onready var door = get_tree().get_first_node_in_group("door")
var movement_speed = 150
var picked_up = ""
var checked_out = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if picked_up and not checked_out:
		navigation_agent_2d.target_position = chest.global_position
	elif checked_out:
		navigation_agent_2d.target_position = door.global_position
	else:
		navigation_agent_2d.target_position = path_box.global_position
	
	#if picked_up:
	#	var test = picked_up.instantiate()
	#	.global_position = self.global_position
	#	add_child(test)
	
	var current_agent_pos = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_vel = current_agent_pos.direction_to(next_path_position) * movement_speed
	if navigation_agent_2d.is_navigation_finished():
		return
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_vel)
	else:
		_on_navigation_agent_2d_velocity_computed(new_vel)
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_vel: Vector2) -> void:
	velocity = safe_vel

func _on_npc_hitbox_area_entered(area: Area2D) -> void:
	print(area)
	if area.name == "hitbox":
		picked_up = area.get_parent()
	if area.name == "chestbox":
		checked_out = true
	if checked_out and area.name == "door_exit":
		queue_free()
