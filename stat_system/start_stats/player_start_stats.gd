class_name PlayerStartStats
extends EntityStartStats

export var name = "Null"
export var move_speed = 10
export var dash_cooldown = 120
export var dash_duration = 20
export var invincible_duration = 10
export var dirt_element = 1
export var water_element = 1
export var fire_element = 1
export var air_element = 1

func _get_stats() -> Dictionary:
	var stats = ._get_stats()
	
	stats["move_speed"] = move_speed
	stats["dash_cooldown"] = dash_cooldown
	stats["dash_duration"] = dash_duration
	stats["invincible_duration"] = invincible_duration
	
	return stats
