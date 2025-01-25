extends Node
## SCORE
var score:int
var tiempo_transcurrido:int

## InputManager
enum GameState {GAMEPLAY, MENU}
var current_state = GameState.MENU
var input_disabled = true

## IMPORTANTE:
# Si se utilizan nodos de Control
# Debera agregarse:
# if InputManager.input_disabled
# Esta linea de if asegura que se desactivan los inputs globalmente

func _ready():
	comenzarAnimacionMenuInicio()

func _input(event: InputEvent) -> void:
	handle_input(event)

func _unhandled_input(event: InputEvent) -> void:
	handle_input(event)

func handle_input(event) -> void:
	if input_disabled:
		print("El input esta desactivado, ya que: input_disabled == true")
		return
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

func comenzarAnimacionMenuInicio() -> void:
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
	ui.comienzaGameplay()
	jugador.habilitar()
	menu.hide()

func _on_menu_termino_animacion_inicio_juego():
	input_disabled = false
