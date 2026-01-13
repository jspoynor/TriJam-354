extends Node

const DARK_DUNGEON_GAME_HIPHOP = preload("uid://ciwdmd5wmosym")
const CONFIRM_1 = preload("uid://b5b1q0mn7tpc8")
const HIT_DAMAGE_1 = preload("uid://cl2jkcktxdsrr")
const GOOD = preload("uid://dni1e8nxdnmcu")
const BAD = preload("uid://ctfwa2ubfoww4")


var player: AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)

	player.stream = DARK_DUNGEON_GAME_HIPHOP
	player.volume_db = 0.0
	player.stream.loop = true

	if DARK_DUNGEON_GAME_HIPHOP:
		player.play()


func play_sfx(sfx: AudioStream = CONFIRM_1) -> void:
	if sfx == null:
		return

	var p := AudioStreamPlayer.new()
	add_child(p)

	p.stream = sfx
	p.autoplay = false
	p.volume_db = 0.0

	p.play()

	# Queue free when sound finishes
	p.finished.connect(func(): p.queue_free())
