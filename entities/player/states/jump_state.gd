extends State
class_name PlayerJumpState

@export var jump_force: float = 350.0

func _ready():
	if not state_value:
		state_value = player_states.EnumState.JUMP
	super()

func enter():
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float):
	super(delta)
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		state_transitionned.emit(self, player_states.EnumState.FALL)
	
	else:
		var movement = move_component.get_movement_direction().x * move_speed
	
		if movement != 0:
			sprite.flip_h = movement < 0
		parent.velocity.x = movement
		parent.move_and_slide()
	
		if parent.is_on_floor():
			state_transitionned.emit(self, player_states.EnumState.IDLE)
