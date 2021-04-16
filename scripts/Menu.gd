extends CanvasLayer

func _ready() -> void:
	$PanelContainer/VBoxContainer/Start.connect("pressed", self, "_on_start_pressed")
	$PanelContainer/VBoxContainer/Exit.connect("pressed", self, "_on_exit_pressed")
	
func _on_start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
