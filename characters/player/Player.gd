extends "res://characters/Character.gd"

signal moved
signal dead
signal grabbed_key
signal open_door
signal win

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$Footsteps.play()
					emit_signal('moved')


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.scale = Vector2(1, 1)


func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		$CollisionShape2D.disabled = true
		set_process(false)
		$Lose.play()
		$AnimationPlayer.play('die')
		yield($Lose, 'finished')
		#yield($AnimationPlayer, 'animation_finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'key_red':
			emit_signal('grabbed_key')
		if area.type == 'star':
			$Win.play()
			$CollisionShape2D.disabled = true
			yield($Win, 'finished')
			emit_signal('win')
