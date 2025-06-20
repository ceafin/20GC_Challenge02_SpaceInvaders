extends Node2D
class_name TitleScreen

func _process(delta: float) -> void:
	var input := Input.is_action_just_pressed("ui_accept")
	
	if input:
		get_tree().change_scene_to_file("res://game_manager.tscn")
