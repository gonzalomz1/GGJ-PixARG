extends Node
## SCORE
var score:int
var tiempo_transcurrido:int

## InputManager
enum GameState {GAMEPLAY, UI}
var current_state = GameState.UI
var input_disabled = false

## IMPORTANTE:
# Si se utilizan nodos de Control
# Debera agregarse:
# if InputManager.input_disabled
# Esta linea de if asegura que se desactivan los inputs globalmente

func _input(event: InputEvent) -> void:
	handle_input(event)

func _unhandled_input(event: InputEvent) -> void:
	handle_input(event)

func handle_input(event) -> void:
	if input_disabled:
		return
	if event is InputEventMouse:
		handle_mouse_input()
	else:
		if GameState.GAMEPLAY:
			var player = get_player()
			player.handle_input(event)
		if GameState.UI:
			var ui = get_ui_node()
			ui.handle_input(event)

func handle_mouse_input():
	pass


func get_player() -> CharacterBody2D:
	return get_node("CharacterBody2D")

func get_ui_node() -> Control:
	var ui
	return ui
