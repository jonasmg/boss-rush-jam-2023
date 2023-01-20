extends StaticBody
class_name PlatformPart


export var texture: Texture = null
export var can_take_damage: bool = true
export var health: int = 3


func _ready():
	add_to_group("platform")
	add_to_group("destroyable")


func take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		queue_free()
