extends State
class_name PlayerIdleState

func _ready():
	if not state_value:
		state_value = player_states.EnumState.IDLE
	super()

func enter():
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

