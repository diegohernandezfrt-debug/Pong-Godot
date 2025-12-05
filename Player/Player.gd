extends CharacterBody2D
# Velocidad de movimiento de la paleta en píxeles por segundo
var speed = 500

# Procesa la física del movimiento en cada frame
# @param delta: Tiempo transcurrido desde el último frame en segundos
func _physics_process(delta):
	# Reinicia la velocidad vertical en cada frame
	velocity.y = 0
	
	# Detecta input del jugador y establece la dirección del movimiento
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	#Movimiento hacia arriba (eje Y negativo)
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	# Movimiento hacia abajo (eje Y positivo)
		
	# Aplica la velocidad configurada a la dirección normalizada
	velocity.y *= speed
	# Mueve la paleta considerando colisiones y el tiempo delta
	# para mantener un movimiento consistente independiente del framerate
	move_and_collide(velocity * delta)
