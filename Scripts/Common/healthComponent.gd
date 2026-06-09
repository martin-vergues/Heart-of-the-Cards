extends Node

class_name HealthComponent

@export var max_health: int = 100
@export var health_bar: bool = true

var _current_health: int = 0
@export var immortal: bool = false
signal on_health_changed(current_health: int, max_health: int)
signal on_damaged(amount: int)
signal on_healed(amount: int)
signal on_dead(parent)

func _ready() -> void:
	_current_health = max_health
	on_health_changed.emit(_current_health, max_health)

func damage(amount: int) -> void:
	if immortal:
		return
	on_damaged.emit(amount)
	print(_current_health)
	amount = min(amount, _current_health)
	_current_health -= amount
	if _current_health <= 0:
		_current_health = 0
		on_dead.emit(get_parent())
	on_health_changed.emit(_current_health, max_health)

func heal(amount: int) -> void:
	var prev_health: int = _current_health
	_current_health = min(_current_health + amount, max_health)
	on_healed.emit(_current_health - prev_health)
	on_health_changed.emit(_current_health, max_health)
func get_current_health() -> int:
	return _current_health

func get_max_health() -> int:
	return max_health
