extends KinematicBody2D


var level_scene : Node2D

var nav_agent : NavigationAgent2D

export var nav_agent_radius : float = 15.0
export var nav_optimize_path : bool = false
export var nav_avoidance_enabled : bool = true
export var character_speed_multiplier : float = 50.0
