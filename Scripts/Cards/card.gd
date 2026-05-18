extends Node

class_name Card

@export var id: int
@export var icon: Sprite2D
@export var readable_name: String
@export var description: String

@export var remaining_uses: int
@export var max_uses: int
@export var cooldown: float

@export var potency: int

func _init(Id: int, Name: String, Description: String, Uses: int, Cooldown: float, Potency:int
	#icon path
	) -> void:
	id = Id
	name = Name
	description = Description
	max_uses = Uses
	remaining_uses = Uses
	cooldown = Cooldown
	potency = Potency

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func use() -> void:
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
