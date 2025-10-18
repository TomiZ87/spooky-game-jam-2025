extends StaticBody2D

@onready var interact_area = $InteractionArea

func _ready():
	interact_area.connect("body_entered", _on_body_entered)
	interact_area.connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.nearby_pickupables.append(self)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.nearby_pickupables.erase(self)
		
func pickup(who):
	print("Player tried to pick up", self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
