extends Area2D
class_name Alien

const ALIEN_SHOT = preload("res://alien_shot.tscn")


func _on_shot_timer_timeout():
	if randi_range(1,20) == 1:
		var bullet = ALIEN_SHOT.instantiate()
		bullet.position = Vector2( round(global_position.x+6), round(global_position.y+4) )
		get_tree().current_scene.find_child("Bullets").add_child(bullet)

func die() -> void:
	GSB.alien_died.emit()
	queue_free()
