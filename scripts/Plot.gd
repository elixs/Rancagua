extends CanvasLayer

var delta_acc = 0

func _ready() -> void:
	$RichTextLabel.percent_visible = 0


func _input(event: InputEvent) -> void:
	var just_pressed = event.is_pressed() and not event.is_echo()
	if event.is_action_pressed("accept") and just_pressed:
		set_process(false)
		LevelManager.next()


func _process(delta: float) -> void:
	delta_acc += delta / 2
	$RichTextLabel.percent_visible = delta_acc
	
	if delta_acc >= 1:
		set_process(false)

