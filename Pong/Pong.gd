extends Node2D
@onready var ball_scene = load("res://Ball/Ball.tscn")

# Posición central de la pantalla utilizada para reiniciar elementos
const CENTER = Vector2(640, 360)
# Puntuación del jugador
var player_score = 0
# Puntuación de la computadora (IA)
var computer_score = 0
var second_ball: Node = null

# Callback ejecutado cuando la pelota entra en el área de gol izquierdo
# @param body: El cuerpo que entró en el área de colisión
func _on_goal_lelt_body_entered(body):
	# Incrementa la puntuación de la computadora
	computer_score += 1
	# Actualiza el texto del marcador en la interfaz (str comvierte el entero int computer_score)
	$ComputerScore.text = str(computer_score)
	check_double_ball()
	# Reinicia el estado del juego
	reset()

# Callback ejecutado cuando la pelota entra en el área de gol derecho
# @param body: El cuerpo que entró en el área de colisión
func _on_goal_right_body_entered(body):
	# Incrementa la puntuación del jugador
	player_score += 1
	# Actualiza el texto del marcador en la interfaz
	$PlayerScore.text = str(player_score)
	check_double_ball()
	# Reinicia el estado del juego
	reset()

func spawn_second_ball():
	second_ball = ball_scene.instantiate()
	add_child(second_ball)
	second_ball.position = CENTER
	second_ball.set_ball_velocity()

func check_double_ball():
	if GameManager.mode != GameManager.GameMode.DOUBLE_BALL:
		return

	if (player_score >= 1 or computer_score >= 1) and !GameManager.second_ball_spawned:
		spawn_second_ball()
		GameManager.second_ball_spawned = true
	
# Reinicia los elementos del juego a su posición inicial
# Se ejecuta después de cada gol para preparar el siguiente turno
func reset():
	# Coloca la pelota en el centro de la pantalla
	$Ball.position = CENTER
	# Reinicia la velocidad de la pelota con una dirección aleatoria
	$Ball.call("set_ball_velocity")
		# --- NUEVO: Mantener segunda pelota funcionando ---
	if second_ball:
		second_ball.position = CENTER
		second_ball.set_ball_velocity()
	# Coloca la paleta del jugador en el centro verticalmente
	$Player.position.y = CENTER.y
	# Coloca la paleta de la computadora en el centro verticalmente
	$Computer.position.y = CENTER.y

# PAUSA
func _input(event):
	if event.is_action_pressed("ui_cancel"): # ESC
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func pause_game():
	get_tree().paused = true
	$PauseMenu.visible = true

func resume_game():
	get_tree().paused = false
	$PauseMenu.visible = false

#Botones

func _on_btn_reaunudar_pressed():
	resume_game()

func _on_btn_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/Main_Menu.tscn")
