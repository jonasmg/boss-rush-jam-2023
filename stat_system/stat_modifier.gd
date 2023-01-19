extends Resource

class_name StatModifier

enum StatType {
	HEALTH,
	ARMOR,
	MOVE_SPEED,
}

export(StatType) var stat
export(float) var value
