extends Control

func animacionComienzoDelJuego() -> void:
	$AnimationPlayer.play("comienzo_del_juego")

func handle_input(event):
	if event is InputEventKey:
		pass
