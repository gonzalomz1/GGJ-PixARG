extends Area2D

func _on_body_entered(body):
	EventManager.sumarScore()
	queue_free()
