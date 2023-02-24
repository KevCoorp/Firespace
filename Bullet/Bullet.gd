extends Area2D

export var speed: float = 500

func _physics_process(delta):
	position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	var cam := get_tree().current_scene.find_node("Cam", true, false)
	cam.shake(1)
	
	if area.is_in_group("damageable"):
		area.damage(1)
		queue_free()
