extends Node2D
class_name StateMachine

var states: Dictionary = {}
var active_state: State

@export var starting_state: State
const player_states: PlayerStateRessource= preload("res://ressources/player_states.tres")

func init(parent: CharacterBody2D, sprite: Sprite2D, animation_player: AnimationPlayer, move_component: Movable):
	for child in get_children():
		if child as State:
			assert(not states.has(child.state_value), "ERROR: State Machine has duplicate state names")
			child.parent = parent
			child.sprite = sprite
			child.animation_player = animation_player
			child.move_component = move_component
			child.state_transitionned.connect(_on_state_transitionned)
			states[child.state_value] = child
	assert(starting_state and states.has(starting_state.state_value), "ERROR: No starting state defined")
	change_state(starting_state.state_value)


func change_state(new_state_value: PlayerStateRessource.EnumState) -> void:
	if active_state:
		active_state.exit()
	active_state = states.get(new_state_value)
	active_state.enter()


func process_input(event: InputEvent):
	if active_state:
		active_state.process_input(event)


func process_frame(delta):
	if active_state:
		active_state.process_frame(delta)


func process_physics(delta):
	if active_state:
		active_state.process_physics(delta)


func _on_state_transitionned(from_state: State, to_state_value: PlayerStateRessource.EnumState):
	if active_state == from_state:
		change_state(to_state_value)
