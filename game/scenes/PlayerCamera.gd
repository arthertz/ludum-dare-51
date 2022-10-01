extends Camera2D

export(NodePath) var target_path
var tween_duration = 1
var _target_pos : Vector2 = Vector2()
var _target : Node2D

func move_to_player() -> void:
	
	var tween := create_tween()
	tween.tween_property(self, "global_position", _target.global_position, tween_duration)

# Called when the node enters the scene tree for the first time.
func _ready():
	_target = get_node(target_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_to_player()
