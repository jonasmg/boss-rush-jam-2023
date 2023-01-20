extends Entity


var save_location := Vector3.ZERO

export var character: Resource = null

onready var animation_manager = $AnimationManager


func _ready() -> void:
	stat_manager.set_stats_from_resource(character)
	stat_manager.add_stat("move_deacceleration", 100)
	stat_manager.add_stat("move_acceleration", 1000)
	stat_manager.add_stat("gravity", Globals.gravity)
	
	save_location = translation
	add_to_group("players")


func get_sprite_blend_position() -> int:
	return 1 if _pivot.rotation_degrees.y >= 0 and _pivot.rotation_degrees.y <= 180 else -1


func handle_movement(delta):
	var y_velocity = _velocity.y
	var move_input := get_move_input()
	var move_direction := Vector3(move_input.x, 0, move_input.y)
	
	if move_direction != Vector3.ZERO:
		var angle := rad2deg(atan2(move_direction.x, move_direction.z))
		_pivot.rotation_degrees.y = angle
		
		_velocity += move_direction * stat_manager.get_stat("move_acceleration") * delta
		_velocity = _velocity.limit_length(stat_manager.get_stat("move_speed"))
	
	_velocity.y = y_velocity


func _update_position() -> void:
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)


func apply_friction(amount: float) -> void:
	if _velocity.length() > amount:
		_velocity -= _velocity.normalized() * amount
	else:
		_velocity = Vector3.ZERO


func apply_gravity(delta: float) -> void:
	_velocity.y -= stat_manager.get_stat("gravity") * delta


func get_move_input() -> Vector2:
	var axis = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	
	return axis
