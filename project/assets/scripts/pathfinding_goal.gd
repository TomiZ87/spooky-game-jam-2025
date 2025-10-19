extends StaticBody2D
@onready var npc_box = get_tree().get_nodes_in_group("npc")
var picked = false
var picked_item

@onready var interact_area = $InteractionArea

func _ready():
	pass
	#interact_area.connect("body_entered", _on_body_entered)
	#interact_area.connect("body_exited", _on_body_exited)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "npc_hitbox":
		picked = true

func _on_body_exited(body):
	if body.is_in_group("npc"):
		body.nearby_pickupables.erase(self)
		
func pickup():
	visible = false
	set_physics_process(false)
	
	# Disable collisions
	$CollisionShape2D.disabled = true
	$InteractionArea/CollisionShape2D.disabled = true
	
	# Don't trigger signals
	$InteractionArea.monitoring = false
	$InteractionArea.monitorable = false

	
func put_down(player):
	visible = true
	set_physics_process(true)
	$CollisionShape2D.disabled = false
	$InteractionArea/CollisionShape2D.disabled = false
	
	# Don't trigger signals
	$InteractionArea.monitoring = true
	$InteractionArea.monitorable = true
	
	var offset = 30 if not player.sprite.flip_h else -30
	position.x = player.position.x + offset
	position.y = player.position.y

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
