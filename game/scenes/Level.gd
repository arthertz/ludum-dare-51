extends Node2D

var crew_guard = []
var crew_civilians = []
var lesser_spawns = []
var crew_spawns = []

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
	for child_node in get_children():
		if child_node is KinematicBody2D:
			if child_node.has_method("ready_character"):
				child_node.ready_character(self, false)

func place_doors() -> void:
	pass

func place_alarms() -> void:
	pass
	
func place_lockers() -> void:
	pass
