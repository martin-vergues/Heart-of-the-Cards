extends Node

var arcana_collection = [
	["Fool", false],					#not implemented
	["Mage", false],					#not implemented
	["High Priestess", false],			#not implemented
	["Empress", false],					#not implemented
	["Emperor", false],					#not implemented
	["Hierophant", false],				#not implemented
	["Lovers", false],					#not implemented
	["Chariot", false],					#not implemented
	["Strength", false],				#not implemented
	["Hermit", false],					#not implemented
	["Wheel of Fortune", false],		#not implemented
	["Justice", false],					#not implemented
	["Hanged Man", false],				#not implemented
	["Death", false],					#not implemented
	["Temperance", false],				#not implemented
	["Devil", false],					#not implemented
	["Tower", false],					#not implemented
	["Star", false],					#not implemented
	["Moon", false],					#not implemented
	["Sun", false],						#not implemented
	["Judgement", false],				#not implemented
	["World", false]					#not implemented
]

var card_collection: Array[int] = [
	0,										#joker
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	#clubs
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	#spades
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	#hearts
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	#diamonds

]

# Called when the node enters the scene tree for the first time.
func _init() -> void:	
	_load_collection_from_config()
	pass # Replace with function body.

func _save_collection_to_config():
	var config = ConfigFile.new()
	#config.set_value("Cards", "major_arcanum", [1,0])
	config.set_value("Cards", "playing_cards", card_collection)
	config.save("res://Config/progress.cfg")

func _load_collection_from_config():
	var config = ConfigFile.new()

	if (config.load("ref://Config/progress.cfg") != OK):
		push_error("couldn't load card collection")
		return
	card_collection = config.get_value("Cards", "playing_cards")

func _can_add_card_to_deck(card_id: int) -> bool:
	if (card_collection[card_id] < 1):
		push_error("No card of this type present in the collection")
		return false
	card_collection[card_id] -= 1
	return true

func _put_card_in_collection(card_id: int):
	card_collection[card_id] += 1

func _set_deck_arcanum(arcanum_id: int) -> bool:
	if arcana_collection[arcanum_id][1] == false:
		push_error("Arcanum not unlocked")
		return false
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
