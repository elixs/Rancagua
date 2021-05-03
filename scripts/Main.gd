extends Node2D

func _ready() -> void:
	$TileMap.set_cell(7, 6, 0, false, false, false, Vector2(3, 3))
	$TileMap.update_bitmask_area(Vector2(7, 6))
