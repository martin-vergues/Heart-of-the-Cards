extends Node

class_name Deck

@export var deck: Array[Card]
@export var hand: Array[Card]
@export var discard: Array[Card]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _draw_card(nb: int) -> void:
	for i in nb:
		#add animation before drawing a card
		hand.push_back(deck.pop_front())

#func _discard_card(id: int) -> void:
	#pop card from hand, add it to a variable, await until the card is off cd, push it back to the deck

#func _shuffle_deck() -> void:
	#check each card in hand if it should be discarded, shuffle the deck, draw 5 cards




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
