extends Node2D

var crew_guards = []
var crew_civilians = []
var lesser_spawns = []
var crew_spawns = []
var doors = []

var level_nav_map
var level_tile_map : TileMap

var game_paused = false

var lesser_spawn_creation_timer : Timer = Timer.new()
export var lesser_spawn_timer_max : float = 17.0 

export var crew_spawn_curr_count : int = 0
export var crew_spawn_count_max : int = 10

var cards = 0
export(int) var max_cards = 5

var willpower_count : int = 0
export var starting_willpower : int = 3
var _willpower_count_max : int = 0

export var alert_level : int = 0

signal willpower_updated(new_value)
signal willpower_max_updated(new_value)
signal card_added()

func _ready() -> void:
	get_node("%EveryTenSeconds").connect('timeout', self, 'increment_willpower')
	get_node("%EveryTenSeconds").connect('timeout', self, 'draw_card')
	level_tile_map = $TileMap
	level_nav_map = get_world_2d().get_navigation_map()
	
	lesser_spawn_creation_timer.start(lesser_spawn_timer_max)
	add_child(lesser_spawn_creation_timer)
	
	set_max_willpower(starting_willpower)
	
	place_characters()
	place_doors()
	place_alarms()
	place_lockers()
	
func increment_willpower() -> void:
	set_willpower(willpower_count + 1)
	
func draw_card() -> void:
	if cards >= max_cards:
		return
	cards += 1
	emit_signal("card_added")
	
func set_willpower(x : int) -> void:
	#first calculate the current max willpower
	var new_maxwp = starting_willpower + cards
	set_max_willpower(new_maxwp)
	
	willpower_count = min(x, _willpower_count_max)
	emit_signal("willpower_updated", willpower_count)

func randomize_max_willpower() -> void:
	var new_wp = randi() % 10 + 1
	set_max_willpower(randi() % 7 + 4)
	print ("Set max willpower to %s" % new_wp)
	
func set_max_willpower(x : int) -> void:
	_willpower_count_max = x
	willpower_count = min(willpower_count, _willpower_count_max)
	emit_signal("willpower_max_updated", _willpower_count_max)

func place_characters() -> void:
	for i in range(5):
		var new_character = load("res://scenes/CrewCivilian.tscn")
		var new_character_scene = new_character.instance()
		$Navigation2D.add_child(new_character_scene)
		# store the character scene reference in the level character array
		crew_civilians.append(new_character_scene)

func place_doors() -> void:
	pass

func place_alarms() -> void:
	pass
	
func place_lockers() -> void:
	pass

func _process(_delta : float) -> void:
	update()
	#create
	
func _draw() -> void:
	pass
	for guard in crew_guards:
		draw_character(guard)
	
	for civilian in crew_civilians:
		draw_character(civilian)
	
	for lesser_spawn in lesser_spawns:
		draw_character(lesser_spawn)
	
	for crew_spawn in crew_spawns:
		draw_character(crew_spawn)

func create_lesser_spawn() -> void:
	pass
func draw_character(character : KinematicBody2D) -> void:
	pass
