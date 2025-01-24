extends Node
## SCORE
var score:int
var tiempo_transcurrido:int

## InputManager
enum GameState {GAMEPLAY, MENU}
var current_state = GameState.MENU

## IMPORTANTE:
# Si se utilizan nodos de Control
# Debera agregarse:
# if InputManager.input_disabled
# Esta linea de if asegura que se desactivan los inputs globalmente

## Bloqueo de todos los inputs si input_disabled es true
func _input(event: InputEvent) -> void:
	handle_input(event)

func _unhandled_input(event: InputEvent) -> void:
	handle_input(event)

func handle_input(event) -> void:
	if current_state == GameState.GAMEPLAY:
		var player = get_player()
		if player:
			player.handle_input(event)  # Pasa el input al jugador
	elif current_state == GameState.MENU:
		var menu = get_menu_node()
		if menu:
			menu.handle_input(event) # Pasa el input al nodo de MENU

func handle_mouse_input():
	pass

func get_player() -> CharacterBody2D:
	return get_node("Jugador")

func get_menu_node() -> Control:
	return get_node("Menu") 

func get_ui_node() -> CanvasLayer:
	return get_node("UI")

func _ready():
	comenzarJuego()

func comenzarJuego() -> void:
	var jugador = get_player()
	var menu = get_menu_node()
	var ui = get_ui_node()
	ui.desabilitar()
	jugador.desabilitar()
	menu.animacionComienzoDelJuego()

func _on_menu_comenzar_juego():
	comenzarGameplay()
	current_state = GameState.GAMEPLAY

func comenzarGameplay() -> void:
	var jugador = get_player()
	var menu = get_menu_node()
	var ui = get_ui_node()
	ui.habilitar()
	jugador.habilitar()
	menu.hide()

func _on_menu_termino_animacion_inicio_juego():
	pass
