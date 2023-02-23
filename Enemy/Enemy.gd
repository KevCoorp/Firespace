extends Area2D
class_name Enemy

export var minSpeed: float = 10
export var maxSpeed: float = 20

export var life: int = 5

var plBullet := preload("res://Bullet/EnemyBullet.tscn")

var speed: float = 0

var playerInArea: Player = null

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _ready():
	speed  = rand_range(minSpeed, maxSpeed)

func _physics_process(delta):
	position.y += speed * delta
	
func fire():
		var bullet := plBullet.instance()
		bullet.position = position
		get_tree().current_scene.add_child(bullet)

func damage(amount: int):
	life -= amount 
	if life <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		area.damage(1)
		playerInArea = area


func _on_Enemy_area_exited(area):
	if area is Player: 
		playerInArea = null
