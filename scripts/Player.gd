extends KinematicBody2D

var lineal_vel = Vector2()
var speed = 500
var gravity = 20

var max_jumps = 2
var jumps = 0

var max_airborne_time = 10
var airborne_time = 0

func _physics_process(delta: float) -> void:
	
	lineal_vel = move_and_slide(lineal_vel, Vector2.UP)
	lineal_vel.y += gravity
	
	var on_floor = is_on_floor()
	
	var target_vel = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if on_floor:
		airborne_time = 0
		jumps = 0
	else:
		airborne_time += delta
	
	if Input.is_action_just_pressed("jump") and jumps < max_jumps:
		if on_floor or airborne_time < max_airborne_time:
			lineal_vel.y = -speed
			jumps += 1
	
	if Input.is_action_just_pressed("dash"):
		lineal_vel = (get_global_mouse_position() - global_position).normalized() * 2 * speed
	
	if on_floor:
		lineal_vel.x = lerp(lineal_vel.x, target_vel * speed, 0.5)
	else:
		lineal_vel.x = lerp(lineal_vel.x, target_vel * speed, 0.1)
