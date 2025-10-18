extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var goal = $"../pathfinding_goal"
var movement_speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var mouse_pos = goal.position #get_global_mouse_position()
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

func _on_navigation_agent_2d_velocity_computed(safe_vel: Vector2) -> void:
	velocity = safe_vel
