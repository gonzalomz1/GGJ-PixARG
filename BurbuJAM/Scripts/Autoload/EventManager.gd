extends Node

## AIRE ES LA VIDA DEL JUGADOR
var aire:float = 100.0
var tiempo:float = 0.0
var velocidad_descenso_aire:float = 1.25 # Velocidad inicial del descenso del aire
var aire_maximo:float = 100.0
var cronometro_activo:bool = false # inactivo por default
var score:int = 0

func sumarScore() -> void:
	score += 25

func resetearScore() -> void:
	score = 0

func restarAire() -> void:
	print("se resto aire")
	aire -= 25

func sumarAire() -> void:
	print("se sumo aire")
	aire += 25
	if aire > 100:
		aire = 100
