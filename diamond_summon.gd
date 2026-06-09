extends Node

enum State {Attacking, Moving, Idle}
var state :State = State.Attacking
@export var lifetime : float
var player :Player
var attack_array = {
	40: flurry,
	41: flurry,
	42: flurry,
	43: flurry,
	44: flurry,
	45: flurry,
	46: flurry,
	47: flurry,
	48: crescent,
	49: spiral_throw,
	50: flurry,
	51: flurry,
	52: flurry
}

var cur_progress : float
var cur_rotation : float
var queued_attacks : Array

func _ready() -> void:
	player = get_node("../../Player")
	state = State.Attacking
	lifetime = 5.0

func _process(delta: float) -> void:
	match state:
		State.Attacking:
			attack_array[queued_attacks[0][0].id].call(delta)
		State.Moving:
			var vec : Vector2 = queued_attacks[0][1].origin
			if (get_parent().position.distance_to(vec) > 1):
				get_parent().velocity = (vec - get_parent().position) * max(get_parent().position.distance_to(vec) * 0.2, 10)
				get_parent().move_and_slide()
			else:
				get_parent().velocity = Vector2(0,0)
				state = State.Attacking
		State.Idle:
			if (get_parent().position.distance_to(player.position) > 100):
				get_parent().velocity = (player.position - get_parent().position) * get_parent().position.distance_to(player.position) * 0.015
			else:
				get_parent().velocity *= 0.98
			lifetime -= 1.0 * delta
			if (lifetime <= 0):
				print(lifetime)
				get_parent().queue_free()
				return
			get_parent().move_and_slide()

func reset_func_state():
	cur_progress = 0.0
	cur_rotation = 0.0
	lifetime = 5.0

func advance_progress(delta, cap):
	cur_progress += 1.0 * delta
	#print(cur_progress)
	if (cur_progress >= cap):
		queued_attacks.pop_front()
		reset_func_state()
		if (queued_attacks.size() == 0):
			state = State.Idle
		else:
			state = State.Moving

func queue_attack(card: Card, transform):
	print("inside")
	queued_attacks.push_back([card, transform])
	match state:
		State.Idle:
			state = State.Moving
		#State.Disabled:
			#get_parent().position = transform.position
			#state = State.Attacking
			#reset_func_state()
#func flurr():
	

func flurry(delta):
	var array: Array[Projectile]
	
	for i in range(3):
		array.push_back(Projectile.new_projectile(queued_attacks[0][0].potency, 2000, 0.3, true, 0, 0))
	for proj in array:
		var coeff = randf_range(-0.8, 0.8)
		player.owner.add_child(proj)
		proj.get_node("AttackAnimation").frame = queued_attacks[0][0].id
		proj.transform = queued_attacks[0][1]
		proj.rotation += coeff
		proj.speed += (coeff * 1000) * coeff
		proj.global_position += Vector2(20,0).rotated(proj.rotation) 
		proj.apply_scale(Vector2(0.5, 0.5))
	advance_progress(delta, 1)

func spiral_throw(delta):
	var proj : Projectile = Projectile.new_projectile(queued_attacks[0][0].potency, 2000, 0.5, true, 0, 0)

	player.owner.add_child(proj)
	proj.get_node("AttackAnimation").frame = queued_attacks[0][0].id
	proj.transform = queued_attacks[0][1]
	proj.rotation += cur_rotation - 3.14
	proj.global_position += Vector2(20,0).rotated(proj.rotation) 
	proj.apply_scale(Vector2(0.5, 0.5))
	cur_rotation += 0.3
	if (cur_rotation >= 6.3):
		advance_progress(delta, 0)

func crescent(delta):
	var array: Array[Projectile]
	var array2 = [-1, 1]

	for i in range(10):
		array.push_back(Projectile.new_projectile(queued_attacks[0][0].potency, 4500, 0.5, true, 0, 0))
	var i = 0
	while i < 10:
		for j in range(2):
			player.owner.add_child(array[i + j])
			array[i + j].get_node("AttackAnimation").frame = queued_attacks[0][0].id
			array[i + j].transform = queued_attacks[0][1]
			array[i + j].apply_scale(Vector2(0.5, 0.5))
			array[i + j].global_position += Vector2(50 -cur_rotation * 3 * (cur_rotation * 0.15), (1 + cur_rotation) * 5 * array2[j]).rotated(array[i + j].rotation) 
		i+=2
		cur_rotation += 2
	advance_progress(delta, -1)


#func land_mine(delta):


func intercontinental_ballistic_missile(delta):
	var ray : RayCast2D
	ray.transform = queued_attacks[0][1]
	ray.target_position = ray.global_position + Vector2(50,0).rotated(ray.rotation)
	
#
#func spiral_throw(delta):
		#var array: Array[Projectile] #Projectile.new_projectile(card.potency, 6000, 2, false, 0, 0))
		##var rotation = 1.55
		#
		#for i in range(22):
			#array.push_back(Projectile.new_projectile(queued_attacks[0][0].potency, 2000, 0.5, false, 0, 0))
		#
		#for proj in array:
			#player.owner.add_child(proj)
			#proj.get_node("AttackAnimation").frame = queued_attacks[0][0].id
			#proj.transform = queued_attacks[0][1]
			#proj.rotation = cur_rotation
			#proj.global_position += Vector2(20,0).rotated(proj.rotation) 
			#proj.apply_scale(Vector2(0.7, 0.7))
			#cur_rotation += 0.3
		#advance_progress(delta, 1)
