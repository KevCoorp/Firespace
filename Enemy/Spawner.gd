extends Node2D

const MIN_SPAWN_TIME = 4

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
	preload("res://Enemy/Enemy.tscn"),
]

@onready var spawnTimer := $SpawnTimer

var nextSpawnTime := 2

var player = null


func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)


func _on_spawn_timer_timeout():
	var viewRect := get_viewport_rect()
	var xPos := randf_range(viewRect.position.x, viewRect.end.x)
	
	if randf() < 0.1:
		pass
	else:
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		var enemy = enemyPreload.instantiate()
		enemy.position = Vector2(xPos, position.y)
		
		get_tree().current_scene.add_child(enemy)
	
	nextSpawnTime -= 0.1
	if nextSpawnTime < MIN_SPAWN_TIME:
		nextSpawnTime = MIN_SPAWN_TIME
	spawnTimer.start(nextSpawnTime)
