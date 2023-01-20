class_name Entity
extends KinematicBody

var _velocity := Vector3.ZERO;
var _snap_vector := Vector3.DOWN
var direction := Vector3.ZERO setget , _get_direction
var angle := 0.0 setget , _get_direction_angle

onready var stat_manager: StatManager = $StatManager
onready var _pivot = $Pivot

func _ready():
	stat_manager.add_stat("health", null)
	add_to_group("entity")


func _update_position() -> void:
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)


func _get_direction_angle() -> float:
	return _pivot.rotation_degrees.y


func _get_direction() -> Vector3:
	return _pivot.rotation_degrees
