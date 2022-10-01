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

var will_countdown : Timer = Timer.new()
var will_timer_max : float = 0
export var willpower_count : int = 0
export var willpower_count_max : int = 0

export var alert_level : int = 0

func _ready() -> void:
	level_tile_map = $TileMap
	level_nav_map = get_world_2d().get_navigation_map()
	
	will_countdown.start(will_timer_max)
	lesser_spawn_creation_timer.start(lesser_spawn_timer_max)
	add_child(will_countdown)
	add_child(lesser_spawn_creation_timer)
	
	place_characters()
	place_doors()
	place_alarms()
	place_lockers()
	
func place_characters() -> void:
	for i in range(5):
		var new_character = load("res://scenes/CrewCivilian.tscn")
		var new_character_scene = new_character.instance()
		add_child(new_character_scene)
		# init after adding as child of the level
		new_character_scene.ready_character(self, true)
		# store the character scene reference in the level character array
		crew_civilians.push_back(new_character_scene)

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
		
	for door in doors:
		if door and is_instance_valid(door) and door.is_inside_tree():
			if door.nav_obstacle.estimate_radius:
				draw_circle(door.global_position, door.collision_radius, Color(0.5, 0.6, 0.4, 1.0))
			else:
				draw_circle(door.global_position, door.obstacle_nav_radius, Color(0.5, 0.6, 0.4, 1.0))
			
func create_lesser_spawn() -> void:
	var new_spawn = load("res://scenes/LesserSpawn.tscn")
	var new_spawn_scene = new_spawn.instance()
	add_child(new_spawn_scene)
	# init after adding as child of the level
	new_spawn_scene.init_character(self, true)
	# store the character scene reference in the level character array
	lesser_spawns.push_back(new_spawn_scene)

func draw_character(character : KinematicBody2D) -> void:
	pass
