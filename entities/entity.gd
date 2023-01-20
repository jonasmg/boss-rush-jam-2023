class_name Entity
extends KinematicBody

var _velocity := Vector3.ZERO;
var _snap_vector := Vector3.DOWN
var direction := 0.0 setget , _get_direction

onready var stat_manager: StatManager = $StatManager
onready var _pivot = $Pivot

func _ready():
	stat_manager.add_stat("health", null)
	add_to_group("entity")


func _get_direction() -> float:
	return _pivot.rotation_degrees.y
