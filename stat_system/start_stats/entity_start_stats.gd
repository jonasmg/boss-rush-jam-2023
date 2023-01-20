class_name EntityStartStats
extends Resource

export var health: int = 3


func _get_stats() -> Dictionary:
	var stats = {
		"health": health
	}
	
	return stats
