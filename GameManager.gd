extends Node

enum GameMode { NORMAL, VELOCITY, DOUBLE_BALL }

var mode : GameMode = GameMode.NORMAL

# Para modo DOUBLE BALL
var second_ball_spawned : bool = false
