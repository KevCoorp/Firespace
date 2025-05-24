extends Control




func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://MainScenes/Gameplay.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
