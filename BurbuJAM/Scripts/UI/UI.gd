extends CanvasLayer

## AIRE ES LA VIDA DEL JUGADOR
var aire:float = 100.0
var tiempo:float = 0.0
var velocidad_descenso_aire:float = 0.5 # Velocidad inicial del descenso del aire
var aire_maximo:float = 100.0
var cronometro_activo:bool = false # inactivo por default

func _ready():
	$GameOverLabel.hide()

# Cada frame
func _physics_process(delta):
	if cronometro_activo:
		if aire > 0.0:
			aire -= velocidad_descenso_aire * delta  # Reducimos el aire gradualmente
			actualizar_barra_aire()
		else:
			fin_del_juego() # Si el aire se termina, el juego finaliza
		
		tiempo+= delta # Incrementar el cronometro
		actualizar_tiempo()
		
		# Ajustar la velocidad del descenso del aire segun el tiempo transcurrido
		ajustar_dificultad()

## ACTUALIZAR INTERFAZ

func actualizar_barra_aire()-> void:
	$Aire.value = aire / aire_maximo * 100 # (valor en porcentaje)

func actualizar_tiempo()-> void:
	$Tiempo.text = "Tiempo: " + str(floor(tiempo)) + " s" # Tiempo redondeado

## SISTEMAS DEL JUEGO

func recoger_burbuja(cantidad:float) -> void:
	aire = min(aire + cantidad, aire_maximo) # No puede superar el maximo 

func ajustar_dificultad() -> void:
	# Incrementa la dificultad de descenso de aire segun el tiempo transcurrido
	if tiempo > 30:
		velocidad_descenso_aire = 1.0
	if tiempo > 60:
		velocidad_descenso_aire = 1.5
	if tiempo > 90:
		velocidad_descenso_aire = 2.0

func fin_del_juego()-> void:
	get_tree().paused = true # Pausa el juego
	print(" Fin del Juego! ")
	$GameOverLabel.show()

## CONTROL DE VISIBILIDAD

func desabilitar() -> void:
	hide()

func habilitar() -> void:
	show()

func comienzaGameplay() -> void:
	habilitar()
	cronometro_activo = true
