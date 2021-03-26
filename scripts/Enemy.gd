extends KinematicBody2D

var Bullet = preload("res://scenes/Bullet.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var bullet = Bullet.instance()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.rotation = (get_global_mouse_position() - global_position).angle()
