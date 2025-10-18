extends TileMapLayer

var astargrid = AStarGrid2D.new()
const main_layer = 0
const main_source = 0
const path_taken_atlas_coords = Vector2i(6, 2)

func _ready() -> void:
	setup_grid()
	show_path()

func setup_grid():
	astargrid.region = Rect2i(3, 8, 11, 20)
	astargrid.cell_size = Vector2i(32, 32)
	astargrid.update()
	
func show_path():
	var path_taken = astargrid.get_id_path(Vector2i(3, 8), Vector2i(3, 0))
	for cell in path_taken:
		set_cell(cell, main_source, path_taken_atlas_coords)
		
