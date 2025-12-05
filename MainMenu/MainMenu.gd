extends Control

func _on_play_button_pressed():
	GameManager.mode = GameManager.GameMode.NORMAL
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")

func _on_btnm_velocidad_pressed():
	GameManager.mode = GameManager.GameMode.VELOCITY
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")

func _on_btnm_pelota_doble_pressed():
	GameManager.mode = GameManager.GameMode.DOUBLE_BALL
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")
