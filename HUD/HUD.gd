extends Control

@onready var score_label = $MarginContainer/Score

func update_score(new_score: int):
	score_label.text = "Score: %d" % new_score
