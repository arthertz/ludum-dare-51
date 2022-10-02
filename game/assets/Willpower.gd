extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var max_willpower = []
var willpower = preload("res://assets/WillpowerBar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_set_willpower(new_val : int) -> void:
	print("Willpower set to %s" % new_val)
	_draw_willpower(new_val)
	
func _on_set_willpower_max(new_val : int) -> void:
	var l = len(max_willpower)
	print("Max willpower set to %s" % new_val)
	if new_val > l:
		for i in range(new_val - l ):
			_create_bar()
	elif new_val < l:
		print("Destroying bars")
		for i in range( l - new_val):
			_destroy_bar(-i)

func _create_bar():
	var new_card = willpower.instance()
	$VBoxContainer.add_child(new_card)
	max_willpower.append(new_card)
	new_card.set_active(false)
	print("Created new willpower bar. Max will is %s" % len (max_willpower))

func _destroy_bar(i):
	var to_destroy = max_willpower[i]
	max_willpower.remove(i)
	to_destroy.queue_free()

func _draw_willpower(wp : int) -> void:
	var l = len(max_willpower)
	for i in range(len(max_willpower)):
		max_willpower[-i].set_active(i < wp)
