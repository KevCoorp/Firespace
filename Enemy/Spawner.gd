extends Node2D

const MIN_SPAWN_TIME = 1.5
const INITIAL_SPAWN_TIME = 2.5
const DIFFICULTY_RAMP = 0.05

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),    # 50% de chance
	preload("res://Enemy/SlowShooter.tscn"), # 30% de chance
	preload("res://Enemy/Enemy.tscn")        # 20% de chance
]

var enemy_weights := [5.0, 3.0, 2.0]

@onready var spawnTimer := $SpawnTimer
var nextSpawnTime := INITIAL_SPAWN_TIME
var player = null

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func choose_enemy():
	var total_weight = enemy_weights.reduce(func(a, b): return a + b)
	var roll: float = randf() * total_weight # Correction du type ici
	var current_weight := 0.0
	
	for i in enemy_weights.size():
		current_weight += enemy_weights[i]
		if roll < current_weight:
			return preloadedEnemies[i]
	return preloadedEnemies[0]

func calculate_spawn_position() -> Vector2:
	var viewRect := get_viewport_rect()
	var spawnMargin := 50
	
	return Vector2(
		randf_range(viewRect.position.x - spawnMargin, viewRect.end.x + spawnMargin),
		randf_range(viewRect.position.y - spawnMargin, viewRect.position.y - 20)
	)

func _on_spawn_timer_timeout():
	# Spawn normal (1 à 3 ennemis)
	for i in randi_range(1, 3):
		var enemy = choose_enemy().instantiate()
		enemy.position = calculate_spawn_position()
		get_parent().call_deferred("add_child", enemy)
		await get_tree().create_timer(0.15).timeout

	# Augmentation progressive de la difficulté
	nextSpawnTime = clamp(nextSpawnTime - DIFFICULTY_RAMP, MIN_SPAWN_TIME, INITIAL_SPAWN_TIME)
	spawnTimer.start(nextSpawnTime + randf_range(-0.2, 0.2))
