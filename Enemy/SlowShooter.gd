extends "res://Enemy/Enemy.gd"

onready var fireTimer := $FireTimer

export var fireRate := 2.5

func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
	
	

