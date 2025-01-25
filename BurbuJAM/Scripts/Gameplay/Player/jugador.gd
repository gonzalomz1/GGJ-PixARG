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
var current_angle: float = 0.0  # Angulo actual del sprite
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
		actualizar_rotacion(velocity)
	
	# Dash
	if Input.is_action_just_pressed("dash"):
		iniciar_dash()

func actualizar_rotacion(vel: Vector2) -> void:
	# Definir los ángulos para cada dirección en radianes
	var direcciones = {
		Vector2.UP: 0.0,
		(Vector2.UP + Vector2.RIGHT).normalized(): PI / 4, # 45°
		Vector2.RIGHT: PI / 2,                            # 90°
		(Vector2.DOWN + Vector2.RIGHT).normalized(): 3 * PI / 4, # 135°
		Vector2.DOWN: PI,                                # 180°
		(Vector2.DOWN + Vector2.LEFT).normalized(): -3 * PI / 4, # 225°
		Vector2.LEFT: -PI / 2,                           # 270°
		(Vector2.UP + Vector2.LEFT).normalized(): -PI / 4 # 315°
	}
	# Si hay movimiento
	if vel.length() > 0:
		# Normalizar la dirección actual
		var direccion_normalizada = vel.normalized()
		# Buscar la dirección más cercana comparando ángulos
		var target_angle = 0.0
		var menor_distancia = INF
		for dir in direcciones.keys():
			var distancia = direccion_normalizada.angle_to(dir)
			if abs(distancia) < menor_distancia:
				menor_distancia = abs(distancia)
				target_angle = direcciones[dir]
		# Interpolar entre el ángulo actual y el ángulo objetivo
		if current_angle != target_angle:
			var tween = create_tween()
			tween.tween_property(
				$AnimatedSprite2D,
				"rotation",
				target_angle,
				0.2
			).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
			tween.play()
			current_angle = target_angle  # Actualizar el ángulo actual
			$AnimatedSprite2D.play()  # Asegurar que la animación se está ejecutando

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

func _on_restar_vida_body_entered(body):
	EventManager.restarAire()
	$AnimationPlayer.play("RecibirGolpe")
	$RestarVida/ColisionRestarVida.disabled = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "RecibirGolpe":
		$RestarVida/ColisionRestarVida.disabled = false
