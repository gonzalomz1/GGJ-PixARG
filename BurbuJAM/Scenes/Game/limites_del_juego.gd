extends Node2D

signal GameOver


func _on_detector_de_obstaculo_area_entered(area):
	$Sur/ColisionSur.disabled = true

func _on_detector_de_obstaculo_area_exited(area):
	$Sur/ColisionSur.disabled = false

func _on_destruye_jugador_area_entered(area):
	emit_signal("GameOver")
