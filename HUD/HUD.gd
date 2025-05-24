extends Control 

@onready var score = $MarginContainer/Score:
	set(value):
		score.text = "Score: " + str(value)
