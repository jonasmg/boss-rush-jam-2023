extends KinematicBody

var move_speed := 10
var move_deacceleration := 100
var move_acceleration := 1000
var gravity := 50

var _velocity := Vector3.ZERO;
var _vertical_velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

export(NodePath) var _camera_path
onready var _camera: Spatial = get_node(_camera_path)

onready var _animated_sprite: AnimatedSprite3D = $AnimatedSprite3D
onready var _anim_tree: AnimationTree = $AnimatedSprite3D/AnimationTree
onready var _anim_tree_state = _anim_tree.get("parameters/playback")
onready var _pivot = $Pivot


func _ready() -> void:
	_animated_sprite.playing = true
	add_to_group("players")


func _physics_process(delta: float) -> void:
	var move_input := get_move_input()
	var y_velocity := _velocity.y
	
	var move_direction := Vector3.ZERO
	move_direction.x = move_input.x
	move_direction.z = move_input.y
	
	if move_direction == Vector3.ZERO:
		apply_friction(move_deacceleration * delta)
	
		set_animation_state("Idle")
	else:
		var angle := rad2deg(atan2(move_direction.x, move_direction.z))
		_pivot.rotation_degrees.y = angle
		
		apply_movement(move_direction * move_acceleration * delta)
		
		set_animation_state("Walk")
		_anim_tree.set("parameters/Idle/blend_position", move_direction.x)
		_anim_tree.set("parameters/Walk/blend_position", move_direction.x)
	
	if not is_on_floor():
		_velocity.y = y_velocity
		apply_gravity(delta)
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	if just_landed:
		_snap_vector = Vector3.DOWN
	else:
		_snap_vector = Vector3.ZERO
	
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	#_velocity = move_and_slide(_velocity, Vector3.UP)
	

func apply_friction(amount: float) -> void:
	if _velocity.length() > amount:
		_velocity -= _velocity.normalized() * amount
	else:
		_velocity = Vector3.ZERO


func apply_movement(acceleration: Vector3) -> void:
	_velocity += acceleration
	_velocity = _velocity.limit_length(move_speed)


func apply_gravity(delta: float) -> void:
	_velocity.y -= gravity * delta

func get_move_input() -> Vector2:
	var axis = Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
	)
	
	return axis


func set_animation_state(new_state: String) -> void:
	_anim_tree_state.travel(new_state)
