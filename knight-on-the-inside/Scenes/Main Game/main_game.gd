extends Control


@export_category("Status Effects")
@export var poison_effect: StatusEffect
@export var curse_effect: StatusEffect
@export var sheild_effect: StatusEffect

# screen textures
@onready var background: TextureRect = $Background
@onready var prisoner: TextureRect = $Prisoner
@onready var foreground: TextureRect = $Foreground
@onready var item_layer: TextureRect = $Item

# ui textures

@onready var item_box: TextureRect = $Control/MarginContainer/Panel/MarginContainer/HBoxContainer/Panel/ItemBox
@onready var item_description: RichTextLabel = $Control/MarginContainer/Panel/MarginContainer/HBoxContainer/Panel2/ItemDescription

# nodes

@onready var take_give_button: Button = $Control/HBoxContainer/TakeGiveButton

const BRICK_WALL = preload("uid://bo6sssv5ssbq0")

enum LookTarget {
	WALL,
	CELL0,
	CELL1,
	CELL2
}

@export_category("Items")
@export var chisel: Item

var possible_items: Array[Item]

var look_target: LookTarget = LookTarget.WALL:
	set(value):
		look_target = value
		_refresh_screen()

var cur_item: Item = null:
	set(value):
		cur_item = value
		_refresh_item_ui(value)

var wall_item: Item

func _generate_wall_item():
	wall_item = possible_items.pick_random()

func _ready() -> void:
	possible_items = [chisel]
	_generate_wall_item()
	_refresh_screen()
	_refresh_item_ui()

func _refresh_screen():
	match look_target:
		LookTarget.WALL:
			foreground.texture = BRICK_WALL
			if wall_item:
				item_layer.texture = wall_item.texture
				return
			item_layer.texture = null
		_:
			pass

func _refresh_item_ui(item: Item = null):
	if item == null:
		take_give_button.text = "Take"
		item_box.texture = null
		item_description.text = ""
	else:
		take_give_button.text = "Give"
		item_box.texture = item.texture
		item_description.text = item.description

func _on_take_give_button_pressed() -> void:
	match look_target:
		LookTarget.WALL:
			if cur_item != null:
				GlobalMusic.play_sfx(GlobalMusic.HIT_DAMAGE_1)
				return
			
			GlobalMusic.play_sfx()
			cur_item = wall_item
			wall_item = null
			_refresh_screen()
			return
		_:
			pass
