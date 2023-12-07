extends Resource
class_name PlayerStateRessource


enum EnumState {
	NULL_STATE,
	IDLE,
	JUMP,
	FALL,
}


func get_state_name(state: EnumState) -> String:
	return EnumState.find_key(state).to_lower()
