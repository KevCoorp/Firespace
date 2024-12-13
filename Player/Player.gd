extends Area2D
class_name Player


# Variable
var plBullet := preload("res://Bullet/Bullet.tscn")
var vel := Vector2(0, 0)

@onready var fireDelayTimer := $FireDelayTimer # Délai de tir
@onready var invincibilityTimer := $InvincibilityTimer # Timer invicilibité
@onready var shieldSprite := $Shield # Bouclier

# Export 
@export var life: int = 3 # Vie
@export var speed: float = 100 # Vitesse
@export var fireDelay: float = 0.1 # Délai de tir
@export var damageInvincibilityTime := 0.5 # Domage du temps de l'invicibilité 



func _ready():
	shieldSprite.visible = false

func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		var bullet := plBullet.instantiate()
		bullet.position = position
		get_tree().current_scene.add_child(bullet)
	

# Déplaçement du vaisseau
func _physics_process(delta):
	var dirVec := Vector2 (0, 0)
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1 
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1 
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1 
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1 
		

	

	vel = dirVec.normalized() * speed
	position += vel * delta
	
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)


# Si le joueur est touché
func damage(amount: int):
	if !invincibilityTimer.is_stopped():
		return
			
	invincibilityTimer.start(damageInvincibilityTime)
	shieldSprite.visible = true
	
	life -= amount
	print("Player Life = %s" % life)
	
	var camera := get_tree().current_scene.find_child("Camera3D", true, false)
	camera.shake(10)
		
	if life <= 0:
		get_tree().change_scene_to_file("res://MainScenes/GameOver.tscn")
		queue_free()

func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false
