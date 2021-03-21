extends Sprite

var acc = 0
onready var init_pos = position.x

func _physics_process(delta: float) -> void:
	acc += 5 * delta
	position.x = init_pos + 100 * sin(acc)
