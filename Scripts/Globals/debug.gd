extends Node

@export var enabled: bool = false

func _ready():
	pass

func _process(delta):
	if !enabled:
		return
	if Input.is_action_pressed("debugKey"):
		if Input.is_action_just_pressed("key1"):
			get_tree().reload_current_scene()
