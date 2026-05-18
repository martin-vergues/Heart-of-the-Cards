extends Node

@export var deck : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _attack():
	if Input.is_action_just_pressed("attack"):
		pass
		#deck._draw_card()
		#if proj_instance != null:
			#var b = proj_instance.instantiate()
			#owner.add_child(b)
			#b.transform = owner.transform
			#b.add_to_group("physics_process_internal")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_attack()
	pass
