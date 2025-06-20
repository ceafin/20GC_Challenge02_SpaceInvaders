extends Area2D
class_name Bunker

var hit_points : int = 6
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.frame = 0

func take_damage() -> void:
	hit_points -= 1
	if hit_points > 0:
		sprite_2d.frame += 1
	else:
		queue_free()
