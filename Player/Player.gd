extends Area2D
class_name Player

var plBullet := preload("res://Bullet/Bullet.tscn")

onready var fireDelayTimer := $FireDelayTimer
onready var invincibilityTimer := $InvincibilityTimer
onready var shieldSprite := $Shield

export var life: int = 3

export var speed: float = 100
export var fireDelay: float = 0.1
export var damageInvincibilityTime := 0.5
var vel := Vector2(0, 0)

func _ready():
	shieldSprite.visible = false

func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		var bullet := plBullet.instance()
		bullet.position = position
		get_tree().current_scene.add_child(bullet)
	
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

func damage(amount: int):
	if invincibilityTimer.is_stopped():
		return
			
	invincibilityTimer.start(damageInvincibilityTime)
	shieldSprite.visible = true
	
	life -= amount
	print("Player Life = %s" % life)
	
	if life <= 0:
		print("Game Over")
		queue_free()

func _on_InvincibilityTimer_timeout():
	shieldSprite.visible = false
