extends Area2D

var bodies = []

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")
	
func on_body_entered(body: Node):
	bodies.append(body)
	
func on_body_exited(body: Node):
	bodies.erase(body)

func _physics_process(delta: float) -> void:
	for body in bodies: 
		if body.has_method("take_damage"):
			body.take_damage(5)
