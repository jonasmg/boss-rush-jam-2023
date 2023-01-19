extends AnimatedSprite3D

onready var parent: Spatial = get_parent()
var camera : Spatial = null

onready var _anim_tree : AnimationTree = $AnimationTree
onready var _parent_pivot : Spatial = $"../Pivot"

func _ready() -> void:
	self.playing = true
	
	add_to_group("directional_sprites")


func _process(delta: float) -> void:
	if camera == null:
		return
	
	var cam_forward := -camera.global_transform.basis.z
	var forward := _parent_pivot.global_transform.basis.z
	var left := _parent_pivot.global_transform.basis.x
	
	var forward_dot := forward.dot(cam_forward)
	var left_dot := left.dot(cam_forward)
	
	var v := Vector2(left_dot, -forward_dot)
	
	_anim_tree.set("parameters/Idle/blend_position", v)
	_anim_tree.set("parameters/Walk/blend_position", v)


func set_camera(camera: Spatial) -> void:
	self.camera = camera
