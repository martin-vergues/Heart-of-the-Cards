extends Area2D
class_name Player

@export var speed = 400
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Signals.on_hurt
	$CollisionShape2D.set_deferred("disabled", true)
