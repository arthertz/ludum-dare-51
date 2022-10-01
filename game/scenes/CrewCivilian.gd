extends KinematicBody2D


var level_scene : Node2D

var nav_agent : NavigationAgent2D

export var nav_agent_radius : float = 15.0
export var nav_optimize_path : bool = false
export var nav_avoidance_enabled : bool = true
export var character_speed_multiplier : float = 50.0

var velocity : Vector2
var nav_destination : Vector2
var next_nav_position: Vector2

var nav_path_normal: Array = []
var nav_path_actual: Array = []

func _ready() -> void:
	# init velocity
	# Vector2.ZERO is enumeration for Vector2(0,0)
	velocity = Vector2.ZERO 
	nav_agent = $NavigationAgent2D
	
	# connect nav agent signal callback functions
	nav_agent.connect("velocity_computed", self, "character_velocity_computed")
	
	# config nav agent attributes
	nav_agent.max_speed = character_speed_multiplier
	nav_agent.radius = nav_agent_radius
	nav_agent.avoidance_enabled = nav_avoidance_enabled
	
	
# init called by parent, inits flow down from parent nodes to create easy parent child references
func ready_character(parent_level_scene : Node2D, instanced_in_code : bool) -> void:
	# set the level_scene easy reference as the init calling level scene
	level_scene = parent_level_scene
	# init position(s) for character scenes created during play
	#randomize()
	global_position = Vector2(randi()%300-100, randi()%300-100)
	#nav_destination = Vector2(0,0)
	#next_nav_position = Vector2(0,0)
	
	nav_destination = Vector2(0,0)
	next_nav_position = Vector2(0,0)
	# set the initial target location to nav_destination
	nav_agent.set_target_location(nav_destination)
	
	
func _physics_process(delta : float) -> void:
	# get the next nav position from the character's navigation agent
	next_nav_position = nav_agent.get_next_location()
	# add the next nav position to the 'real' path for draw function
	nav_path_actual.push_back(next_nav_position)
	# calculate the desired velocity, i.e velocity pre nav server calculated
	var desired_velocity = global_position.direction_to(next_nav_position) * character_speed_multiplier
	
	# feed the desired into the navigation agent 
	# set_velocity will trigger a callback from velocity_computed signal
	nav_agent.set_velocity(desired_velocity)


func set_navigation_position(nav_position_to_set : Vector2) -> void:
	nav_destination = nav_position_to_set
	
	# set the new character target location
	nav_agent.set_target_location(nav_destination)
	
	# calculate a new map path with the server using character nav agent map and new nav destination
	nav_path_normal = Navigation2DServer.map_get_path(nav_agent.get_navigation_map(), global_position, nav_destination, nav_optimize_path)
	
	# clear the old real nav path, used for draw function
	nav_path_actual.clear()


func character_velocity_computed(calculated_velocity : Vector2) -> void:
	velocity = calculated_velocity
	
	# check if nav agent target is reached
	if !nav_agent.is_target_reached():
		# move and slide with the new calculated velocity
		velocity = move_and_slide(velocity)
	else:
		# if reached target, stand at the closest point in the navigation map
		global_position = Navigation2DServer.map_get_closest_point(nav_agent.get_navigation_map(), global_position)

