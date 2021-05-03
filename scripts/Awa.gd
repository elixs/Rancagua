extends Area2D

var speed = 200
var SPEED = 200
var linear_vel = Vector2.ZERO

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")
	connect("area_entered", self, "on_area_entered")


func _physics_process(delta: float) -> void:

	linear_vel += Vector2.DOWN * SPEED *  delta
	
	position += linear_vel * delta
	
	rotation = linear_vel.angle()
	
	
	
	
func on_body_entered(body: Node):
	if body is TileMap:
		queue_free()

func on_area_entered(area: Area2D):
	if not area.is_in_group("awa"):
		queue_free()
		area.queue_free()

func fire_to(target: Vector2):
	linear_vel = (target - global_position).normalized() * SPEED
	
