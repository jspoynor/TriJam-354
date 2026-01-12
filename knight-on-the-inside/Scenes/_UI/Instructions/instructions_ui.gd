extends Control


func _on_button_pressed() -> void:
	GlobalMusic.play_sfx()
	get_tree().change_scene_to_file("res://Scenes/Main Game/main_game.tscn")
