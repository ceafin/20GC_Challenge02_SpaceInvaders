extends Area2D
class_name PlayerTank

@export var speed : float = 100.0
@export var y_pos : float = 134.0

const PLAYER_SHOT = preload("res://player_shot.tscn")

var real_position : Vector2

@onready var shot_timer: Timer = $ShotTimer

func _ready() -> void:
	position = Vector2( get_viewport_rect().size.x/2-6, y_pos )
	real_position = position
	

func _process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	
	real_position.x += direction * speed * delta
	real_position.y = y_pos
	position = real_position.round()
	
	if Input.is_action_just_pressed("shoot") and ( !shot_timer.time_left ):
		var player_shot := PLAYER_SHOT.instantiate()
		player_shot.position = Vector2( round(global_position.x+6), round(global_position.y+0) )
		get_tree().current_scene.find_child("Bullets").add_child(player_shot)
		
		shot_timer.start()

func die() -> void:
	GSB.player_died.emit()
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Alien:
		die()
