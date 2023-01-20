class_name PlayerAnimationManager
extends Node


onready var _animated_sprite: AnimatedSprite3D = $"../AnimatedSprite3D"
onready var _anim_tree: AnimationTree = $"../AnimatedSprite3D/AnimationTree"
onready var _anim_tree_state = _anim_tree.get("parameters/playback")


func _ready():
	_animated_sprite.playing = true
	_anim_tree.active = true
	

func set_animation_state(new_state: String) -> void:
	_anim_tree_state.travel(new_state)
