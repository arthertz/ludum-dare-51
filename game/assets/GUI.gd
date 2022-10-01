extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("%Level").connect('willpower_updated', $Willpower, '_on_set_willpower')
	get_node("%Level").connect('willpower_max_updated', $Willpower, '_on_set_willpower_max')
	get_node("%Level").connect('card_added', $Cards, 'draw_card')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta)
#	pass
