class_name PlayerStateMachine
extends StateMachine


func _ready():
	add_state("idle")
	add_state("walk")
	add_state("fall")
	call_deferred("set_state", states.idle)


func _state_logic(delta: float):
	match state:
		states.idle:
			parent.apply_friction(parent.stat_manager.get_stat("move_deacceleration") * delta)
		states.walk:
			parent.handle_movement(delta)
			parent.apply_gravity(delta)
		states.fall:
			parent.handle_movement(delta)
			parent.apply_gravity(delta)
	
	parent._update_position()


func _get_transition(_delta: float):
	match state:
		states.idle:
			if !parent.is_on_floor():
				return states.fall
			elif parent.get_move_input().length() > 0:
				return states.walk
		states.walk:
			if !parent.is_on_floor():
				return states.fall
			elif parent.get_move_input().length() <= 0:
				return states.idle
		states.fall:
			if parent.is_on_floor():
				return states.idle
	
	return null


func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.animation_manager.set_animation_state("Idle")
		states.walk:
			parent.animation_manager.set_animation_state("Walk")


func _exit_state(old_state, new_state):
	if old_state == states.fall:
		parent._snap_vector = Vector3.DOWN
	elif new_state == states.fall:
		parent._snap_vector = Vector3.ZERO
