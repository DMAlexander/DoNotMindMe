extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("press_space"):
		GameManager.load_game_scene()
