extends Node
class_name MovementHandler

@export var speed: float = 200.0
@export var enabled: bool = true
var player: Player
@export var animation: AnimatedSprite2D

func _ready():
	player = get_parent() as Player
	if player == null:
		push_error("MovementHandler must be a child of Player")

func _process(delta):
	if !enabled:
		return
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
	handle_animation(velocity)
	player.velocity = velocity * speed
	player.move_and_slide()

func handle_animation(velocity: Vector2):
	#if velocity.length() == 0:
		#animation.play("Idle")
		#return
	#animation.play("Run")
	if velocity.x > 0:
		animation.flip_h = false
	elif velocity.x < 0:
		animation.flip_h = true
