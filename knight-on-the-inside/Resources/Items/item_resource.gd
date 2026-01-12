extends Resource
class_name Item

enum NeighborBehavior {
	NONE,
	PICK_RANDOM,
	BOTH
}

@export_category("Item Info")
@export var name: String
@export var texture: Texture2D
@export_multiline var description: String

@export_category("Prisoner Behavior")
@export_range(-5, 5, 1) var add_escape: int = 1
@export var add_status: StatusEffect = null

@export_category("Neighbor Behavior")
@export var neighbor_behavior := NeighborBehavior.NONE
@export_range(-5, 5, 1) var neighbor_add_escape: int = -1
@export var add_neighbor_status: StatusEffect = null
