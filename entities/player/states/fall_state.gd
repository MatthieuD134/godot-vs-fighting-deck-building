extends State
class_name PlayerFallState

func _ready():
	if not state_value:
		state_value = player_states.EnumState.FALL
	super()


func process_physics(delta: float):
	super(delta)
	parent.velocity.y += gravity * delta
	
	if parent.is_on_floor():
		state_transitionned.emit(self, player_states.EnumState.IDLE)
		
	parent.move_and_slide()
