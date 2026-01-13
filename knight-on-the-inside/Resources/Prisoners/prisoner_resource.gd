extends Resource
class_name Prisoner

@export var name: String
@export var texture: Texture2D

@export var escape_level: int = 3
@export var status_effects: Array[StatusEffect] = []
@export var has_escaped: bool = false
