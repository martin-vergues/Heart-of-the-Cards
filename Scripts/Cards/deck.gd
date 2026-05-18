extends Node

class_name Deck

@export var arcanum_id: int
@export var deck: Array[Card]
@export var hand: Array[Card]
@export var discard: Array
@export var player: Player
@export var noderef: NodePath
var functions: Array


var hand_changed: bool

signal update_hand()
#signal update_arcanum()
#signal share_deck(convenient_var: Deck)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	functions = get_node(noderef).func_array
	#_save_deck_to_config()
	_load_deck_from_config()
	update_hand.emit(hand)
	#get_parent()._can_add_card_to_deck(1)
	pass # Replace with function body.



#func _share_deck(convenient_var: Deck):
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_use_card()

	_update_discard(delta)
	if (Input.is_action_just_pressed("shuffle")):
		print("shuf")
		_shuffle_deck()
	
	_draw_card(5 - hand.size())
	if hand_changed:
		update_hand.emit(hand)
		hand_changed = false

func _use_card() -> void:
	for card in hand:
		#if (card == null):
			#continue
		if functions[card.id].call(card) == true:
			match card.remaining_uses:
				-1:
					break
				1:
					card.remaining_uses = 0
					_remove_used_cards()
					hand_changed = true
				_:
					card.remaining_uses -= 1
					hand_changed = true
			return
			#if card.remaining_uses > 0:
				#card.remaining_uses -= 1
				#hand_changed = true
				#if card.remaining_uses == 0:
					#_remove_used_cards()
			#break

func _draw_card(nb: int) -> void:
	for i in nb:
		#add animation before drawing a card
		var card_buf : Card = deck.pop_front()
		if (card_buf == null):
			pass
			#var j = deck.size()
			#while j != 0:
				#print(deck[j])
			#print("print done")
		else:
			hand.push_back(card_buf)
		#hand.push_back(deck.pop_front())
		

#check each card in hand if it should be discarded, shuffle the deck, draw 5 cards
func _shuffle_deck() -> void:
	for card in hand:
		_discard_card(card)
	deck.shuffle()
	hand = []
	hand_changed = true

##----------------DISCARD FUNCTIONS----------------##


func _remove_used_cards() -> void:
	var new_hand : Array[Card] = []

	for card in hand:
		if card == null:
			print("why")
			continue
		if card.remaining_uses == 0:
			print("discard")
			_discard_card(card)
		else:
			new_hand.push_back(card)
	hand = new_hand
	update_hand.emit(hand)


func _update_discard(delta) -> void:
	var i = discard.size() - 1

	while i >= 0:
		discard[i][1] -= 1 * delta
		if (discard[i][1] < 0):
			print("cooldown is up")
			deck.push_back(discard[i][0])
			discard.remove_at(i)
			hand_changed = true
			return
		i -= 1

#pop card from hand, add it to a variable, await until the card is off cd, push it back to the deck
func _discard_card(card: Card) -> void:
	var cd = (card.cooldown * ((card.max_uses - card.remaining_uses) / card.max_uses))

	card.remaining_uses = card.max_uses
	discard.push_back([card, cd])


##----------------CONFIG FUNCTIONS----------------##


func _save_deck_to_config():
	var config = ConfigFile.new()
	config.set_value("Deck", "playing_cards", [1,2,3,4,5])
	config.set_value("Deck", "major_arcanum", 0)
	config.save("res://Saves/deck.cfg")

func _load_deck_from_config():
	var deck_save = ConfigFile.new()
	var card_data = ConfigFile.new()

	if ((deck_save.load("res://Config/deck.cfg") != OK) or (card_data.load("res://Config/card_data.cfg") != OK)):
		push_error("could not load deck data")
		queue_free()
		return

	var array = deck_save.get_value("Deck", "playing_cards")
	for i in array:
		var section = str(i)
		if (card_data.has_section(str(i)) == false):
			section = "0"
		#var section = card_data.get_section(str(i))
		deck.push_back(Card.new(
			i,
			card_data.get_value(section, "name"),
			card_data.get_value(section, "flavor_text"),
			card_data.get_value(section, "uses"),
			card_data.get_value(section, "cooldown"),
			card_data.get_value(section, "potency")
			))
	_shuffle_deck()
	_draw_card(5)
