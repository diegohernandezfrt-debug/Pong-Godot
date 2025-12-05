extends CharacterBody2D

# Velocidad de movimiento de la pelota en píxeles por segundo
var speed = 500
var speed_increase = 30   # Cuánto sube en cada rebote
var max_speed = 1200      # Velocidad máxima permitida

# Inicializa la pelota al cargar la escena
func _ready():
	set_ball_velocity()
	GameManager.second_ball_spawned = false
	
# Establece una velocidad inicial aleatoria en ambos ejes
# Asegura que la pelota se mueva en una dirección impredecible
func set_ball_velocity():
	# Genera dirección aleatoria en el eje X (izquierda o derecha)
	if randi() % 2 == 0:
		velocity.x = 1
	# Movimiento hacia la derecha
	else:
		velocity.x = -1
	# Movimiento hacia la izquierda
		
	# Genera dirección aleatoria en el eje Y (arriba o abajo)
	if randi() % 2 == 0:
		velocity.y = 1
	# Movimiento hacia abajo
	else:
		velocity.y = -1
	# Movimiento hacia arriba
	
	# Aplica la velocidad configurada al vector de dirección normalizado
	velocity *= speed
	
# Procesa el movimiento y las colisiones de la pelota en cada frame
# @param delta: Tiempo transcurrido desde el último frame en segundos
func _physics_process(delta):
	# Ejecuta el movimiento y captura información de colisión
	var collsion_info = move_and_collide(velocity * delta)
	
	# Si ocurrió una colisión, refleja la velocidad según la normal de la superficie
	if collsion_info:
		velocity = velocity.bounce(collsion_info.get_normal())
		var collider = collsion_info.get_collider()
			# Si choca con pared
		
		#estas condiciones son para reporducir sonido al tener colision
		if collider.is_in_group("wall"):
			$WallSound.play()
			# Si choca con paleta
		elif collider.is_in_group("paddle"):
			$PlayerSound.play()
			
			#Aumentar velocidad progresivamente
			if GameManager.mode == GameManager.GameMode.VELOCITY:
				var new_speed = velocity.length() + speed_increase
				new_speed = min(new_speed, max_speed)
				velocity = velocity.normalized() * new_speed
