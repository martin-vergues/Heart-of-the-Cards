extends Node

class_name CardFunctions

@export var player : Player

var func_array: Array[Callable] = [
	d,											#joker
	d, d, d, d, d, d, d, d, d, d, d, d, d,	#clubs
	_spade_ace, _spade_two, _spade_three, _spade_four, d, _spade_six, d, d, d, d, d, d, d,	#spades
	d, d, d, d, d, d, d, d, d, d, d, d, d,	#hearts
	d, d, d, d, d, d, d, d, d, _diamond_ten, d, d, d	#diamonds
]

func d(card: Card) -> bool: #dummy
	return false

func _spade_ace(card: Card) -> bool:
	if Input.is_action_just_pressed("attack"):
		var proj : Projectile = Projectile.new_projectile(card.potency, 6000, 1, true, 0, 0)
		player.owner.add_child(proj)
		proj.get_node("Sprite2D").frame = card.id
		proj.transform = player.get_node("Muzzle").global_transform
		return true
	return false

func _spade_two(card: Card) -> bool:
	if Input.is_action_just_pressed("attack"):
		var array = []
		for i in range(2):
			array.push_back(Projectile.new_projectile(card.potency, 4000, 0.4, false, 0, 0))

		var pos = -100
		for proj in array:
			player.owner.add_child(proj)
			proj.get_node("Sprite2D").frame = card.id
			proj.transform = player.get_node("Muzzle").global_transform.translated_local(Vector2(0, pos))
			pos += 200
		return true
	return false

func _spade_three(card: Card) -> bool:
	if Input.is_action_just_pressed("attack"):
		var rotation = -0.15
		var array = []
		for i in range(3):
			array.push_back(Projectile.new_projectile(card.potency, 4000, 0.3, false, 0, 0))

		for proj in array:
			player.owner.add_child(proj)
			proj.get_node("Sprite2D").frame = card.id
			proj.transform = player.get_node("Muzzle").global_transform
			proj.rotation += rotation
			rotation += 0.15
		return true
	return false

func _spade_four(card: Card) -> bool:
	return true

func _spade_six(card: Card) -> bool:
	if Input.is_action_just_pressed("attack"):
		var array = []
		for i in range(3):
			array.push_back(Projectile.new_projectile(card.potency, 6000, 0.1, true, 0, 0))

		var rotation = 0.9
		var pos = -30
		for proj: Projectile in array:
			player.owner.add_child(proj)
			proj.get_node("Sprite2D").frame = card.id
			proj.transform = player.get_node("Muzzle").global_transform
			proj.rotation += rotation
			proj.transform = proj.transform.looking_at(player.get_node("Muzzle").pos).translated(Vector2(100, 100))
			#proj.transform.origin = (Vector2(proj.position.x, proj.position.y))
			proj.position.y += pos
			proj.position.x -= 10
			pos += 30
		return true
	return false

#func _diamond_ace(card: Card) -> bool:
	

func _diamond_ten(card: Card) -> bool:
	if (Input.is_action_just_pressed("attack")):
		#spadeTenThread(card)
		get_parent().get_node("Thread_manager")._get_available_thread().start(flurry.bind(card))
		return true
	return false

func flurry(card: Card):
	var array: Array[Projectile]
	#var rotation = 1.55
		
	for i in range(33):
		array.push_back(Projectile.new_projectile(card.potency, 2000, 2, false, 0, 0))
	var temp_transfo = player.global_transform
	for proj in array:
		player.owner.add_child(proj)
		proj.get_node("Sprite2D").frame = card.id
		#proj.transform = player.get_node("Muzzle").global_transform
		proj.transform = temp_transfo
		proj.rotate(randf_range(-1, +1))
		proj.speed *= randf_range(0.7, 1.3)
		proj.apply_scale(Vector2(0.7, 0.7))
		await get_tree().create_timer(0).timeout

func spiral_throw(card:Card):
		#player = owner
		var array: Array[Projectile] #Projectile.new_projectile(card.potency, 6000, 2, false, 0, 0))
		var rotation = 1.55
		
		for i in range(22):
			array.push_back(Projectile.new_projectile(card.potency, 2000, 2, false, 0, 0))
		
		for proj in array:
			#player.owner.call_deferred("add_child", proj) # add_child(proj)
			player.owner.add_child(proj)
			proj.get_node("Sprite2D").frame = card.id
			#proj.transform = player.get_node("Muzzle").global_transform
			proj.transform = player.global_transform#player.get_node("Muzzle").global_transform
			proj.rotation = rotation
			proj.apply_scale(Vector2(0.7, 0.7))
			rotation += 0.3
			await get_tree().create_timer(0).timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
