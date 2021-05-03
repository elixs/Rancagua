class_name Player

extends KinematicBody2D

var Awa = preload("res://scenes/Awa.tscn")

var lineal_vel = Vector2()
var speed = 400
var gravity = 20

var max_jumps = 20
var jumps = 0

var max_airborne_time = 10
var airborne_time = 0

var facing_right = true

var can_take_damage = true

# gamplay
var uwu = 100 setget set_uwu
func set_uwu(value):
	uwu = value
	$CanvasLayer/VBoxContainer/uwu/ProgressBar.value = uwu

var awa = 100 setget set_awa
func set_awa(value):
	awa = value
	$CanvasLayer/VBoxContainer/awa/ProgressBar.value = awa

onready var playback = $AnimationTree.get("parameters/playback")


func _ready() -> void:
	$Invulnerability.connect("timeout", self, "on_invulnerability_ended")

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
	
	
	if Input.is_action_just_pressed("fire"):
		fire()
	
	
	if on_floor:
		lineal_vel.x = lerp(lineal_vel.x, target_vel * speed, 0.5)
	else:
		lineal_vel.x = lerp(lineal_vel.x, target_vel * speed, 0.1)
	
	if Input.is_action_just_pressed("move_left") and facing_right:
		facing_right = false
		scale.x = -1
	if Input.is_action_just_pressed("move_right") and not facing_right:
		facing_right = true
		scale.x = -1
	
	# Animations
	
	if on_floor:
		if abs(lineal_vel.x) > 10:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if lineal_vel.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")

func _input(event: InputEvent) -> void:
	var just_pressed = event.is_pressed() and not event.is_echo()
	if event.is_action_pressed("menu") and just_pressed:
		$PauseMenu.toggle()

func take_damage(damage):
	if not can_take_damage:
		return
	self.uwu = max(0, uwu - damage)
	if uwu == 0:
		get_tree().reload_current_scene()
	can_take_damage = false
	$Invulnerability.start()
	$AnimationPlayer2.play("auchis")

func on_invulnerability_ended():
	can_take_damage = true

func landed():
	$Particles2D.emitting = true

func fire():
	var awa = Awa.instance()
	awa.global_position = $Awa.global_position
	get_parent().add_child(awa)
	awa.fire_to(get_global_mouse_position())
