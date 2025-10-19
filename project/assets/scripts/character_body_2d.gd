extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var carried_object = $CarriedObject
@onready var sprite = $Sprite2D
@onready var chest = get_tree().get_first_node_in_group("chest_area")
@onready var path_box = get_tree().get_first_node_in_group("inter_area")
@onready var door = get_tree().get_first_node_in_group("door")

var movement_speed = 150
var picked_up: Node = null
var carrying = false
var nearby_pickupables: Array = []
var checked_out = false

func get_node_in_group(node: String):
	var return_node
	for nodes in get_node_in_group(node).get_tree():
		if nodes != null:
			return_node = nodes
		nodes = null
		
	return return_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_pickup()
	if picked_up and not checked_out and chest != null:
		navigation_agent_2d.target_position = chest.global_position
	elif checked_out:
		navigation_agent_2d.target_position = door.global_position
	else:
		navigation_agent_2d.target_position = path_box.global_position
	
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
	if area.name == "InteractionArea":
		handle_pickup()
	if area.name == "chestbox":
		checked_out = true
	if checked_out and area.name == "door_exit":
		queue_free()
		
func handle_pickup():
	# Clean up if any interactables were deleted
	nearby_pickupables = nearby_pickupables.filter(func(i): return is_instance_valid(i))
	# Find the closest one (if any)
	if nearby_pickupables.size() > 0 and not picked_up:
		picked_up = get_closest_interactable()
	#else:
	#	picked_up = null

	# Handle interaction input

	if not carrying and picked_up:
		picked_up.pickup()
		carrying = true
		carried_object.carry(picked_up)
		#picked_up = null

func get_closest_interactable():
	var closest = null
	var min_dist = INF
	for obj in nearby_pickupables:
		var dist = global_position.distance_to(obj.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = obj
	return closest


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "chestbox":
		print("borde droppa")
		carried_object.drop(self)
		
