extends CharacterBody2D


const SPEED = 150.0
@onready var sprite = $AnimatedSprite2D

func get_input():
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

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	get_input()
	move_and_slide()
