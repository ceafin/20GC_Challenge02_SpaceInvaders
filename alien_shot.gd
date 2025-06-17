extends Area2D

@export var speed : float = 10.0


func _process( delta: float ) -> void:
	global_position = Vector2( global_position.x, global_position.y + speed )


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
