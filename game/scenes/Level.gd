extends Node2D

var crew_guard = []
var crew_civilians = []
var lesser_spawns = []
var crew_spawns = []

var level_nav_map
var level_tile_map

var game_paused = false

export var lesser_spawn_creation_timer : float = 10.0
export var lesser_spawn_timer_max : float = 17.0 

export var crew_spawn_curr_count : int = 0
export var crew_spawn_count_max : int = 10

export var will_countdown : float = 10.0
var will_timer_max : float = 0
export var willpower_count : int = 0
export var willpower_count_max : int = 0
export var alert_level : int = 0

func _ready() -> void:
	level_navigation_map = get_world_2d().get_navigation_map()
