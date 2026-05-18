extends Node

@export var ref_deck : Deck
@export var pat : NodePath
var card_array: Array[Card_Display]
signal update_hand()
signal update_arcanum()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_array.push_back(get_node("Card_array/Card 1"))
	card_array.push_back(get_node("Card_array/Card 2"))
	card_array.push_back(get_node("Card_array/Card 3"))
	card_array.push_back(get_node("Card_array/Card 4"))
	card_array.push_back(get_node("Card_array/Card 5"))
	#update_arcanum.connect(_update_arcanum)
	#update_hand.connect(_update_hand)

func _receive_deck(convenient_ref: Deck):
	ref_deck = convenient_ref

func _update_arcanum() -> void:
	$Arcanum.frame = ref_deck.arcanum_id

func _update_hand(ref_hand : Array) -> void:
	var hand_size = ref_hand.size()
	var i = 0

	while i < 5:
		if (i < hand_size):
			card_array[i]._update_data(ref_hand[i])
		else:
			card_array[i]._update_data(null)
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
