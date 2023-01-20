class_name StatModifier

enum StatModifierType {
	ADD,
	MULTIPLY
}

var type
var amount


func calculate(value):
	match type:
		StatModifierType.ADD:
			return value + amount
		StatModifierType.MULTIPLY:
			return value * amount
	
	return value
