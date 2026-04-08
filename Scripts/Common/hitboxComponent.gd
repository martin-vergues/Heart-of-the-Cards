extends Area2D
class_name HitboxComponent
@export var health_component: HealthComponent
@export var team: Globals.Team = Globals.Team.ENEMY
signal on_hurt(damage_amount: int)

func _ready() -> void:
	on_hurt.connect(_on_hurt)

func _on_hurt(damage_amount: int) -> void:
	if health_component:
		health_component.damage(damage_amount)
