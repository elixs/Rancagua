extends Area2D

var speed = 200

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")
	
func on_body_entered(body: Node):
	if body.is_in_group("player"):
		print("owo")
		queue_free()


func _physics_process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta
