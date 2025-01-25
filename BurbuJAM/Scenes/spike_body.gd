extends CharacterBody2D


var player_chase = false
var player = null

@export var speed = 5.0
var current_speed = 0.0



func _physics_process(delta):
	position.y += current_speed	
	
func _on_area_2d_body_entered(body):
	player = body
	player_chase = true
	fall()


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false

func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	queue_free()
