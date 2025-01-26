extends RigidBody2D

func _ready():
	$AnimationPlayer.play("default")

func _on_area_2d_body_entered(body):
	print("colisiono la burbuja con el jugador")
	EventManager.sumarAire()
	queue_free()
