extends Node

#var main_game_scene: PackedScene = preload("res://main.tscn")

enum Team {
	PLAYER,
	ENEMY,
	NEUTRAL
}

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

#func start_game():
	#TransitionManager.change_scene(Global.main_game_scene)
