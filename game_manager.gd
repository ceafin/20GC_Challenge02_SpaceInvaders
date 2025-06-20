extends Node2D
class_name GameManager

const PLAYER_TANK = preload("res://player_tank.tscn")

@export var player_lives : int = 3

var player_score : int = 0

@onready var initial_world: Node2D = $InitialWorld
@onready var respawn_timer: Timer = $RespawnTimer
@onready var ui: CanvasLayer = $UI
@onready var score_text: Label = $UI/HUD/HBox/ScoreText
@onready var lives_text: Label = $UI/HUD/HBox/LivesText
@onready var respawn_overlay: Control = $UI/RespawnOverlay

func _ready() -> void:
	GSB.alien_died.connect(Callable( self, "_on_alien_died" ))
	GSB.player_died.connect(Callable( self, "_on_player_died" ))
	score_text.text = str(player_score)
	lives_text.text = str(player_lives)

func _on_alien_died() -> void:
	player_score += 100
	score_text.text = str(player_score)


func _on_player_died() -> void:
	print( "Game Manager heard the Player died!")
	player_lives -= 1
	lives_text.text = str(player_lives)
	if player_lives > 0:
		print( "Player still has lives left!")
		$UI/RespawnOverlay/Label.text = "Get Ready!"
		respawn_overlay.visible = true
		respawn_timer.wait_time = 3
		respawn_timer.start()
	else:
		initial_world.process_mode = Node.PROCESS_MODE_DISABLED
		$UI/RespawnOverlay/Label.text = "Game Over!"
		respawn_overlay.visible = true

func _on_respawn_timer_timeout() -> void:
	var player = PLAYER_TANK.instantiate()
	initial_world.add_child(player)
	respawn_overlay.visible = false
