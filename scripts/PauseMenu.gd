extends CanvasLayer

func _ready() -> void:
	$PanelContainer/VBoxContainer/Continue.connect("pressed", self, "_on_continue_pressed")
	$PanelContainer/VBoxContainer/Retry.connect("pressed", self, "_on_retry_pressed")
	$PanelContainer/VBoxContainer/Exit.connect("pressed", self, "_on_exit_pressed")
	
func _on_continue_pressed():
#	get_tree().paused = false
	hide()
	
	
func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menu.tscn")

func show():
	$PanelContainer.show()
	get_tree().paused = true

func hide():
	$PanelContainer.hide()
	get_tree().paused = false

func toggle():
	if $PanelContainer.visible:
		hide()
	else:
		show()
