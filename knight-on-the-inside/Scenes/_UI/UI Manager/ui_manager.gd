extends CanvasLayer

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var title_screen: Control = $CanvasLayer/TitleScreen

const INSTRUCTIONS_UI = preload("uid://bjbjiqiedhet4")

func _on_button_pressed() -> void:
	GlobalMusic.play_sfx()
	title_screen.queue_free()
	
	var instructions = INSTRUCTIONS_UI.instantiate()
	canvas_layer.add_child(instructions)
