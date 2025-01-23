extends Node2D

# Velocidad de desplazamiento hacia arriba
var velocidad_scroll: int = 100

# Frecuencia de generacion de obstaculos
var intervalo_spawn: int = 1.5
var timer_spawn: float = 0.0

# Tamanio del area visible
var alto_viewport: int = 720
var ancho_viewport: int = 1280

func _process(delta):
	# Desplazar los nodos hacia abajo
	scroll_escena(delta)
	timer_spawn += delta

func scroll_escena(delta) -> void:
	pass
