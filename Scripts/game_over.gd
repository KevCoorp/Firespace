extends Control

@onready var score_label = $Score 

func set_score(final_score: int):
	score_label.text = "Final Score: %d" % final_score

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://MainScenes/Gameplay.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
