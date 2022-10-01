extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Color) var full = Color.blue
export(Color) var empty = Color.red

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_active(activated : bool) -> void:
	if activated:
		self.color = full
	else:
		self.color = empty
