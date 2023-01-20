class_name Stat


var base_value
var value setget _set_value, _get_value
var _value = null
var _is_dirty = true
var _modifiers: Dictionary


func _init(base_value_):
	self.base_value = base_value_


func add_modifier(key: String, modifier):
	_is_dirty = true
	_modifiers[key] = modifier


func remove_modifier(key: String) -> bool:
	return _modifiers.erase(key)


func _set_value(new_value):
	_is_dirty = true
	base_value = new_value


func _get_value():
	if _is_dirty:
		_value = base_value
		
		for modifier in _modifiers.values():
			_value = modifier.calculate(_value)
		
		_is_dirty = false
	
	return _value
