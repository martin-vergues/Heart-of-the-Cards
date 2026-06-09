extends CharacterBody2D
class_name Player

@export var speed = 1000
@export var muzzle : Marker2D

var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("player start")
	screen_size = get_viewport_rect().size
	#var projectile = Proj.instantiate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print("ouch")
	Signals.on_hurt
	$CollisionShape2D.set_deferred("disabled", true)
