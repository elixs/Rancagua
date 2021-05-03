extends Area2D

var speed = 200

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")


func _physics_process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func on_body_entered(body: Node):
	if body.is_in_group("player"):
		var player: Player = body
		player.take_damage(5)
		queue_free()
	if body is TileMap:
		queue_free()
