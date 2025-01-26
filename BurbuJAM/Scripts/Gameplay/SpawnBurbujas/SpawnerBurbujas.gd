extends Node2D

class_name SpawnerBurbujas
const ESCENA_BURBUJA = "res://Scenes/Game/burbuja.tscn"
@onready var Posiciones = [
	$Posicion1,
	$Posicion2,
	$Posicion3,
	$Posicion4,
	$Posicion5,
	$Posicion6,
	$Posicion7,
	$Posicion8,
	$Posicion9
]

func comenzarAFuncionar() -> void:
	$Timer.start(0)

func _on_timer_timeout():
	var posicion_aleatoria = obtenerNodoAleatorio()
	spawnearBurbuja(posicion_aleatoria)

func obtenerNodoAleatorio() -> Node:
	if Posiciones.size() > 0:  # Asegúrate de que la lista no esté vacía
		var index_random = randi() % Posiciones.size()
		return Posiciones[index_random]
	return null  # Retorna null si la lista está vacía

func spawnearBurbuja(nodoElegido: Node) -> void:
	var burbuja = preload(ESCENA_BURBUJA).instantiate()
	nodoElegido.add_child(burbuja)
