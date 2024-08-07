extends Control

@onready var score : Label = $Score
@onready var lives : Label = $Lives

func set_score_label(new_score : int) -> void:
	score.text = "Score: " + str(new_score)

func set_lives(lives_left : int) -> void:
	lives.text = str(lives_left)
