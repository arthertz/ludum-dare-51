extends Node2D

var crew_guard = []
var crew_civilians = []
var lesser_spawns = []
var crew_spawns = []

var level_nav_map
var level_tile_map

var game_paused = false

export var = lesser_spawn_creation_timer
export var = lesser_spawn_timer_max

export var = crew_spawn_curr_count
export var = crew_spawn_count_max

export var = alert_level

func _ready() -> void:
	level_navigation_map = get_world_2d().get_navigation_map()
