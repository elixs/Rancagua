extends Node2D

var Levels = [
	"res://scenes/Menu.tscn",
	"res://scenes/Main.tscn",
	]

var current_level = 0
var current_world: Node = null
var loading = false
var loading_world = ""

onready var fade = $CanvasLayer/Fade

func _ready():
	fade.connect("faded", self, "on_faded")
	current_world = load(Levels[0]).instance()
	$World.add_child(current_world)
	
	set_process(false)
	
	ResourceQueue.start()
	
	
	

func change_scene(scene):
	var s = load(scene).instance()
	$World.remove_child(current_world)
	current_world.queue_free()
	current_world = s
	$World.add_child(current_world)

func add_scene(scene):
	get_tree().paused = true
	fade.fade_in()
	yield(fade, "faded")
	var s = load(scene).instance()
	$World.add_child(s)
	fade.fade_out()

func remove_scene(scene_node):
	
	fade.fade_in()
	yield(fade, "faded")
	$World.remove_child(scene_node)
	scene_node.queue_free()
	fade.fade_out()
	get_tree().paused = false
 
func next():
	if current_level + 1 >= Levels.size():
		return
	loading = true
	fade.fade_in()


func on_faded():
	if loading:
		$World.remove_child(current_world)
		current_world.queue_free()
		current_level += 1
	
		loading_world = Levels[current_level]
		ResourceQueue.queue_resource(loading_world)
		set_process(true)
		

		
func reset():
	current_level = -1
	loading = true
	fade.fade_in()

func _process(delta: float) -> void:
	$CanvasLayer/Fade.set_progress(ResourceQueue.get_progress(loading_world))
	if ResourceQueue.is_ready(loading_world):
		var new_world = ResourceQueue.get_resource(loading_world)
		current_world = new_world.instance()
		$World.add_child(current_world)
		loading = false
		fade.fade_out()
		set_process(false)
