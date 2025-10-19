extends Control
@onready var padding = 3
@onready var max_bar_length = size.x - 2 * padding
@onready var bar_height = size.y - 2 * padding
var satisfaction_percentage = 0

func _ready():
	$Label.text = "Customer Satisfaction: 0%"
	
func _draw():
	draw_rect(Rect2(0, 0, size.x, size.y), Color(1, 1, 1, 0.8))
	var stsf = 1
	if stsf > 1:
		stsf = 1
	draw_rect(Rect2(padding, padding, max_bar_length * stsf, bar_height), Color(1, 0.7, 0, 0.8))

func _on_timer_end(weight):
	satisfaction_percentage -= weight
	$Label.text = "Customer Satisfaction: " + satisfaction_percentage + "%"
	queue_redraw()
