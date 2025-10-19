extends Node2D

@onready var sprite = $Sprite2D
@onready var object: Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func carry(obj):
	var obj_sprite = obj.get_node_or_null("Sprite2D")
	object = obj
	if obj_sprite:
		sprite.texture = obj_sprite.texture
	else:
		push_warning("Picked up object sprite not found")

func drop(player):
	object.put_down(player)
	object = null
	sprite.texture = null
