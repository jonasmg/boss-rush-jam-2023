extends Node


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("destroyable", "take_damage", 1)
