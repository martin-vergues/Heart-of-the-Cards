extends CharacterBody2D

func destroy(enemy) -> void:
	print("ded")
	queue_free()


func _physics_process(delta: float) -> void:
	pass
