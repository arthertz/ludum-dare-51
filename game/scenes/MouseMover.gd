extends Sprite

export var tween_duration = 1.0

func _unhandled_input(event) -> void:
	# TODO: Replace with remapped input
	if event is InputEventMouseButton and event.pressed:
		move_to_mouse()
		
func move_to_mouse() -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position", get_global_mouse_position(), tween_duration)
		
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
