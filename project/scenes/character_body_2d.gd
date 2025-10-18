extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var goal = $pathfinding_goal
@onready var chest = $chest
@onready var path_box = get_tree().get_nodes_in_group("pathfind_placeholder")
var movement_speed = 150
var picked_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var mouse_pos = goal.position #get_global_mouse_position()
	if picked_up:
		navigation_agent_2d.target_position = chest.position
	else:
		navigation_agent_2d.target_position = goal.position
	
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
	print(picked_up)

func _on_navigation_agent_2d_velocity_computed(safe_vel: Vector2) -> void:
	velocity = safe_vel

func _on_npc_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		picked_up = area.get_parent()
