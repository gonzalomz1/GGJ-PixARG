extends Control

signal terminoAnimacionInicioJuego
signal comenzarJuego


func animacionComienzoDelJuego() -> void:
	$AnimationPlayer.play("comienzo_del_juego")
	await $AnimationPlayer.animation_finished
	emit_signal("terminoAnimacionInicioJuego")

func handle_input(event):
	if Input.is_action_pressed("confirmar") && $botonComenzar.visible:
		print("se presiono confirmar y el boton comenzar esta visible")
		irAGameplay()

func _on_boton_comenzar_pressed():
	irAGameplay()

func irAGameplay() -> void:
	emit_signal("comenzarJuego")
