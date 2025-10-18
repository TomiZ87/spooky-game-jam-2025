extends CharacterBody2D

const SPEED = 150.0
@onready var sprite = $AnimatedSprite2D
@onready var carried_object = $CarriedObject

var nearby_pickupables: Array = []
var current_pickupable: Node = null
var carrying = false

func _process(delta):
	handle_pickup()

func _physics_process(delta: float) -> void:
	handle_movement_input()
	move_and_slide()

func handle_movement_input():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

	if direction.x == 0 and direction.y == 0:
		sprite.play("idle_right")
	else:
		sprite.play("walk_right")

	velocity = direction * SPEED

func handle_pickup():
	# Clean up if any interactables were deleted
	nearby_pickupables = nearby_pickupables.filter(func(i): return is_instance_valid(i))
	# Find the closest one (if any)
	if nearby_pickupables.size() > 0:
		current_pickupable = get_closest_interactable()
	else:
		current_pickupable = null

	# Handle interaction input
	if Input.is_action_just_pressed("player_pick_up_put_down"):
		if not carrying and current_pickupable:
			current_pickupable.pickup()
			carrying = true
			carried_object.carry(current_pickupable)
			current_pickupable = null
		elif carrying:
			carried_object.drop(self)
			carrying = false



func get_closest_interactable():
	var closest = null
	var min_dist = INF
	for obj in nearby_pickupables:
		var dist = global_position.distance_to(obj.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = obj
	return closest
