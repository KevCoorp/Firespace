extends Node2D

@onready var hud = $UI/HUD

var score := 0:
	set(value):
		score = value
		hud.score = score

func _ready():
	hud.score = 0
	
func _on_spawn_timer_timeout():
	var new_enemy = preload("res://Enemy/Enemy.tscn").instantiate()
	add_child(new_enemy)
	
	# Connect the signal when enemy is spawned
	new_enemy.killed.connect(_on_enemy_killed)
	
func _on_enemy_killed():
	score += 1
	$Spawner/SpawnTimer.wait_time = 1.5


	
