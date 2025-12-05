extends CharacterBody2D

# Velocidad de movimiento de la IA o CPU en píxeles por segundo
var speed = 450
# Referencia al nodo de la pelota para el seguimiento
var ball

# Inicializa las referencias necesarias al cargar la escena
func _ready():
	ball = get_parent().get_node("Ball")
	# Obtiene la referencia a la pelota desde el nodo padre
	
# Procesa el comportamiento de la IA en cada frame
# @param delta: Tiempo transcurrido desde el último frame en segundos
func _physics_process(delta):
	# Zona muerta: detiene el movimiento si la paleta está suficientemente alineada
	# Evita oscilaciones innecesarias cuando la diferencia es menor a 10 píxeles
	#Esto se hace porque al moverse la pelota en horizontal proboca que tiemble la paleta
	if abs(ball.position.y - position.y) < 10:
		return
	
	# Determina la dirección del movimiento según la posición de la pelota
	if ball.position.y < position.y:
		velocity.y = -1
	# La pelota está arriba, mover hacia arriba
	else:
		velocity.y = 1
	# La pelota está abajo, mover hacia abajo
		
	# Aplica la velocidad configurada al vector de dirección normalizado
	velocity *= speed
	
	# Ejecuta el movimiento considerando colisiones y delta time
	# para mantener consistencia independiente del framerate
	move_and_collide(velocity * delta)
		
