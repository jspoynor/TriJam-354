extends Control


@export_category("Status Effects")
@export var poison_effect: StatusEffect
@export var curse_effect: StatusEffect
@export var sheild_effect: StatusEffect

# screen textures
@onready var background: TextureRect = $Background
@onready var prisoner: TextureRect = $Prisoner
@onready var foreground: TextureRect = $Foreground
@onready var item_layer: TextureRect = $ItemLayer

# ui textures

@export_category("Nodes")
@export var item_box: TextureRect
@export var item_description: RichTextLabel
@export var escape_label: Label
@export var take_give_button: Button

@export_category("Prisoners")
@export var prisoner_1: Prisoner
@export var prisoner_2: Prisoner
@export var prisoner_3: Prisoner

const BRICK_WALL = preload("uid://bo6sssv5ssbq0")
const BACKGROUND = preload("uid://2nr57r5r5opx")
const FOREGROUND = preload("uid://bba0vmfmt1lw8")
const BROKE_FREE = preload("uid://cjircir6scre1")
const GUY_1 = preload("uid://bial03o0oyqam")
const GUY_2 = preload("uid://dk8kmgkrjjrfs")
const GUY_3 = preload("uid://c0a2tuk835uyf")


enum LookTarget {
	WALL,
	CELL0,
	CELL1,
	CELL2
}

@export_category("Items")
@export var chisel: Item

var possible_items: Array[Item]

var look_targets: Array[LookTarget] = [LookTarget.WALL, LookTarget.CELL0, LookTarget.CELL1, LookTarget.CELL2]

var look_target: int = 0:
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
	match look_targets[look_target % look_targets.size()]:
		LookTarget.WALL:
			escape_label.text = ""
			prisoner.texture = null
			foreground.texture = BRICK_WALL
			if wall_item:
				take_give_button.disabled = false
				item_layer.texture = wall_item.texture
				return
			take_give_button.disabled = true
			item_layer.texture = null
		_:
			if cur_item == null:
				take_give_button.disabled = true
			else:
				take_give_button.disabled = false
			escape_label.text = " / 10"
			background.texture = BACKGROUND
			foreground.texture = FOREGROUND
			item_layer.texture = null
			match look_targets[look_target % look_targets.size()]:
				LookTarget.CELL0:
					prisoner.texture = prisoner_1.texture
					escape_label.text = escape_label.text.insert(0, str(prisoner_1.escape_level))
				LookTarget.CELL1:
					prisoner.texture = prisoner_2.texture
					escape_label.text = escape_label.text.insert(0, str(prisoner_2.escape_level))
				LookTarget.CELL2:
					prisoner.texture = prisoner_3.texture
					escape_label.text = escape_label.text.insert(0, str(prisoner_3.escape_level))

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
	match look_targets[look_target % look_targets.size()]:
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

func _on_left_button_pressed() -> void:
	GlobalMusic.play_sfx()
	look_target += -1

func _on_right_button_pressed() -> void:
	GlobalMusic.play_sfx()
	look_target += 1
