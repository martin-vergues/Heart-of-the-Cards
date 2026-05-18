extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Card_UI.ref_deck = $Player/Card_collection/Deck
	#$CanvasLayer/Card_UI.update_arcanum()
	#$CanvasLayer/Card_UI.update_hand()
	$Player/Card_collection/Deck.update_hand.connect($CanvasLayer/Card_UI._update_hand)
	#$Player/Card_collection/Deck
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
