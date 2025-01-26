extends Control

signal terminoAnimacionInicioJuego
signal comenzarJuego

func animacionComienzoDelJuego() -> void:
	$botonComenzar.hide()
	$botonComenzar.disabled = true
	$AnimationPlayer.play("comienzo_del_juego")

func reproducirVideoIntro() -> void:
	$IntroInicio.play()

func pausarVideoIntro() -> void:
	$IntroInicio.paused = true

func reproducirVideoGameOver() -> void:
	$GameOver.play()

func pausarVideoGameOver() -> void:
	$GameOver.paused = true

func handle_input(event):
	if Input.is_action_pressed("confirmar") && ($botonComenzar.visible || $botonRejugar.visible):
		irAGameplay()

func _on_boton_comenzar_pressed():
	irAGameplay()

func _on_boton_rejugar_pressed():
	irAGameplay()

func irAGameplay() -> void:
	emit_signal("comenzarJuego")

func luegoDePausarElVideo() -> void:
	$botonComenzar.show()
	$botonComenzar.disabled = false
	emit_signal("terminoAnimacionInicioJuego")

