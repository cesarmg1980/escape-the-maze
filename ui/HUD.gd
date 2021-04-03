extends CanvasLayer

func _ready():
	$MarginContainer/ScoreLabel.text = "Points: " + str(Global.score)

func update_score(value):
	Global.score += value
	$MarginContainer/ScoreLabel.text = "Points: " + str(Global.score)
