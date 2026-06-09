extends Node2D

class_name Projectile

@export var speed = 6000
@export var lifetime = 2.0
@export var bounces : int
@export var piercing : bool
#@export var faction : int
@export var damage : int

static func new_projectile(Damage: int, Speed: int, Lifetime: float, Piercing: bool, Bouncing: int, Faction: int) -> Projectile:
	var new_proj : Projectile = preload("res://Scenes/Entities/card_projectile.tscn").instantiate()
	new_proj.damage = Damage
	new_proj.speed = Speed / 1
	new_proj.lifetime = Lifetime
	new_proj.piercing = Piercing
	new_proj.bounces = Bouncing
	#new_proj.get_node("AttackAnimation").animation = "card_projectile_anims"
	#new_proj.faction = Faction
	#new_proj.get_node("Attack").damage = Damage
	return new_proj

func _physics_process(delta):
	position += transform.x * speed * delta

func _process(delta):
	$Attack.hurt_entities(damage)
	lifetime -= 1 * delta
	if (lifetime <= 0):
		queue_free()
		return

func _on_bullet_body_entered(body):
	#if body.is_in_group("mobs"):
		#body.queue_free()
	#queue_free()
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
