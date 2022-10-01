extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var card
var hand = []

# Called when the node enters the scene tree for the first time.
func _ready():
	card = load("res://assets/Card.tscn")

func draw_card():
	var new_card = card.instance()
	$HBoxContainer.add_child(new_card)
	hand.append(new_card)
