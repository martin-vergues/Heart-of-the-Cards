extends Area2D
class_name HurtboxComponent

var hitboxes : Array[HitboxComponent] = []
@export var team: Globals.Team = Globals.Team.NEUTRAL
@export var constant = false

signal on_hurt(entity)

func _on_area_exited(area: Area2D):
	if (!area is HitboxComponent):
		return
	hitboxes.erase(area)

func _on_area_entered(area: Area2D):
	if (!area is HitboxComponent):
		return
	if area.team == team and area.team != Globals.Team.NEUTRAL:
		return
	hitboxes.append(area)

func hurt_entities(damage_amount: int):
	#todo: handle special state for multihit attacks
	if hitboxes.size() == 0:
		return
	for hitbox in hitboxes:
		Signals.on_hurt.emit(hitbox)
		hitbox.on_hurt.emit(damage_amount)
		hitboxes.erase(hitbox)
	if constant:
		hitboxes.clear()
		
