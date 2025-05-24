extends Node2D

@onready var hud = $CanvasLayer/HUD
@onready var game_over_screen = $GameOver

var score := 0:
	set(value):
		score = value
		hud.update_score(score)  # Call a method in HUD to update the display

func _ready():
	score = 0  # Initialize score
	# Connect enemy signals (if enemies are spawned dynamically)

# Call this when an enemy dies
func _on_enemy_killed(points: int):
	score += points

# Call this when the player dies
func _on_player_death():
	game_over_screen.set_score(score)
	game_over_screen.visible = true
