extends AnimatedSprite2D

class_name Card_Display

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _update_data(card:Card) -> void:
	if card == null:
		$ProgressBar.hide()
		if frame != 0:
			position.y += 30
		frame = 0
		return
	if frame == 0:
		position.y -= 30
	frame = card.id
	$ProgressBar.show()
	$ProgressBar.max_value = card.max_uses
	$ProgressBar.value = card.remaining_uses

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
