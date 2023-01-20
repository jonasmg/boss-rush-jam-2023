class_name StatManager
extends Node


var stats = {}


func add_stat(stat_name: String, base_value, override := false) -> void:
	if not stat_name in stats or override:
		stats[stat_name] = Stat.new(base_value)


func get_stat(stat_name: String):
	return stats[stat_name].value


func set_stat(stat_name: String, new_value) -> void:
	stats[stat_name].value = new_value


func get_stat_object(stat_name: String) -> Stat:
	return stats[stat_name]


func set_stats_from_resource(stats_resource: Resource) -> void:
	var resource_stats = stats_resource._get_stats()
	
	for key in resource_stats:
		add_stat(key, resource_stats[key], true)
