extends KinematicBody2D

export var path_to_monster := NodePath()

var level_scene : Node2D

onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
onready var timer = $Timer

var max_speed : float = 500.0
var velocity : Vector2 = Vector2.ZERO

func _ready() -> void:
	nav_agent.set_target_location(get_global_mouse_position())
	timer.connect("timeout",self, "_update_pathfinding")
	global_position = Vector2(randi()%500-250,randi()%500-250)

func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		print("finished")
		return
		
	var direction := global_position.direction_to(nav_agent.get_next_location())
	print(direction)
	var desired_velocity := direction * max_speed
	var steering := (desired_velocity - velocity) * delta * 4.0
	velocity += steering
	
	velocity = move_and_slide(velocity)

func _update_pathfinding() -> void:
	nav_agent.set_target_location(get_global_mouse_position())
