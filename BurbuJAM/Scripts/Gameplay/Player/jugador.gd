extends CharacterBody2D

class_name Jugador # Clase del jugador

# Constantes
const SPEED = 300.0
const DASH_SPEED = 800.0 # Velocidad del dash
const DASH_DURATION = 0.2 # Duracion en segundos del dash

## Variables
@onready var camara = $Camera2D
@onready var escudo = $Escudo
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
var dash_timer: float = 0.0
# Sacamos la gravedad directamente del setting del proyecto.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


## INPUT
func handle_input(event: InputEvent) -> void:
	if is_dashing:
		return # Si dasheamos, ignoramos otros inputs
	# Reseteamos la velocidad inicial
	velocity = Vector2.ZERO
	# Procesamos el movimiento horizontal y vertical
	if Input.is_action_pressed("izquierda"):
		velocity.x -= SPEED
	if Input.is_action_pressed("derecha"):
		velocity.x += SPEED
	if Input.is_action_pressed("arriba"):
		velocity.y -= SPEED
	if Input.is_action_pressed("abajo"):
		velocity.y += SPEED

	# Normalizamos para movimiento diagonal (mismo SPEED)
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	# Dash
	if Input.is_action_just_pressed("dash"):
		iniciar_dash()

## FISICA
func _physics_process(delta):
	if is_dashing:
		# Durante el dash, movemos al jugador en la direccion del mismo
		velocity = dash_direction * DASH_SPEED
		dash_timer -= delta
		if dash_timer <= 0.0:
			terminar_dash()
	# Mover al personaje
	move_and_slide()

## DASH
func iniciar_dash() -> void:
	is_dashing = true
	dash_timer = DASH_DURATION
	
	# La direccion del dash es la direccion actual de movimiento
	if velocity.length() > 0:
		dash_direction = velocity.normalized()
	else:
		# Si no hay input de movimiento, el dash por defecto es hacia arriba
		dash_direction = Vector2.UP
		## HAY QUE AGREGAR EFECTOS VISUALES Y SONIDO
	print("DASH REALIZADO HACIA: ", str(dash_direction))

func terminar_dash() -> void:
	is_dashing = false
	dash_direction = Vector2.ZERO
	velocity = Vector2.ZERO
	print("DASH FINALIZADO")
	# Procesamos el input actual para actualizar el movimiento
	if Input.is_action_pressed("izquierda"):
		velocity.x -= SPEED
	if Input.is_action_pressed("derecha"):
		velocity.x += SPEED
	if Input.is_action_pressed("arriba"):
		velocity.y -= SPEED
	if Input.is_action_pressed("abajo"):
		velocity.y += SPEED

func desabilitar() -> void:
	camara.enabled = false
	hide()
	set_physics_process(false)

func habilitar() -> void:
	camara.enabled = true
	show()
	set_physics_process(true)
