extends Node2D

var difficulty: int = 1

func _on_DifficultyTimer_timeout() -> void:
	difficulty +=1
	Signals.emit_signal("difficulty_increased", difficulty)
