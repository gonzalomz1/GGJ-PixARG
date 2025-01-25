extends CharacterBody2D
class_name Jugador # agregue yo
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var camara = $Camera2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_input(event: InputEvent) -> void:
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

func _physics_process(delta):
	# Aplicar gravedad si no está en el suelo
	if not is_on_floor():
		velocity.y += gravity * delta
	# Mover al personaje
	move_and_slide()

func desabilitar() -> void:
	camara.enabled = false
	hide()
	set_physics_process(false)

func habilitar() -> void:
	camara.enabled = true
	show()
	set_physics_process(true)
