extends Area2D

# The object currently stored on the shelf
var stored_object: Node2D = null

# Track if player is nearby
var player_in_range: bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		body.nearby_shelf = self

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		if body.nearby_shelf == self:
			body.nearby_shelf = null

# Called by the player when dropping the carried object while inside shelf area
func store_object(obj: Node2D):
	stored_object = obj
	obj.visible = false
	obj.set_physics_process(false)

	# Disable collisions and interaction
	if obj.has_node("CollisionShape2D"):
		obj.get_node("CollisionShape2D").disabled = true
	if obj.has_node("InteractionArea/CollisionShape2D"):
		obj.get_node("InteractionArea/CollisionShape2D").disabled = true
	if obj.has_node("InteractionArea"):
		obj.get_node("InteractionArea").monitoring = false
		obj.get_node("InteractionArea").monitorable = false

	print("Object stored on shelf")

# Called by the player when retrieving the object from the shelf
func retrieve_object() -> Node2D:
	if stored_object:
		var obj = stored_object
		stored_object = null
		obj.visible = true
		obj.set_physics_process(true)

		if obj.has_node("CollisionShape2D"):
			obj.get_node("CollisionShape2D").disabled = false
		if obj.has_node("InteractionArea/CollisionShape2D"):
			obj.get_node("InteractionArea/CollisionShape2D").disabled = false
		if obj.has_node("InteractionArea"):
			obj.get_node("InteractionArea").monitoring = true
			obj.get_node("InteractionArea").monitorable = true

		print("Object retrieved from shelf")
		return obj

	return null
