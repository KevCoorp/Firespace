extends Area2D
class_name Enemy

signal enemy_died(points: int)  # Signal emitted when the enemy dies

@export var verticalSpeed := 100
@export var health: int = 3
@export var points := 50

var playerInArea: Player = null

func _process(delta):
	if playerInArea != null:
		playerInArea.damage(1)

func _physics_process(delta):
	position.y += verticalSpeed * delta

func damage(amount: int):
	if health <= 0:
		return
	
	health -= amount
	if health <= 0:
		emit_signal("enemy_died", points)  # Emit signal with points before dying
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area
		
func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = null
