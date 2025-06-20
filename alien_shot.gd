extends Area2D
class_name AlienShot

@export var speed : float = 1.0

var did_damage := false

func _process( delta: float ) -> void:
	global_position = Vector2( global_position.x, global_position.y + speed )


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is PlayerTank and area.has_method("die"):
		area.die()
		queue_free()
	elif area is Bunker:
		area.take_damage()
		queue_free()
