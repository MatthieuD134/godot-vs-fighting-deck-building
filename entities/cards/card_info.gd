class_name CardInformation

var title: String
var description: String
var sprite_path: String


func _init(effect_state: PlayerStateRessource.EnumState):
	title = get_card_title(effect_state)
	description = get_card_description(effect_state)
	sprite_path = get_card_sprite_path(effect_state)


func get_card_title(effect_state: PlayerStateRessource.EnumState) -> String:
	match effect_state:
		PlayerStateRessource.EnumState.JUMP:
			return "jump"
		_:
			return ""

func get_card_description(effect_state: PlayerStateRessource.EnumState) -> String:
	match effect_state:
		PlayerStateRessource.EnumState.JUMP:
			return "cool cool"
		_:
			return ""

func get_card_sprite_path(effect_state: PlayerStateRessource.EnumState) -> String:
	match effect_state:
		PlayerStateRessource.EnumState.JUMP:
			return "res://entities/cards/assets/jump.png"
		_:
			return ""
