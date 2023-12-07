extends Node
class_name State

signal state_transitionned(current_state: State, new_state_value: PlayerStateRessource.EnumState)

var parent: CharacterBody2D
var sprite: Sprite2D
var animation_player: AnimationPlayer
var move_component: Movable


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
const player_states: PlayerStateRessource = preload("res://ressources/player_states.tres")


@export var state_value: PlayerStateRessource.EnumState
@export var move_speed: float = 160.0


func _ready():
	assert(state_value, "ERROR: state_value not defined")

func enter() -> void:
	animation_player.play(self.get_state_name())


func exit() -> void:
	pass


func process_input(_event: InputEvent):
	pass


func process_frame(_delta: float):
	pass


func process_physics(_delta: float):
	var next_move = move_component.get_next_move()
	if next_move and next_move != player_states.EnumState.NULL_STATE:
		move_component.set_next_move(player_states.EnumState.NULL_STATE)
		state_transitionned.emit(self, next_move)
		return


# always return lower case name of the state
func get_state_name() -> String:
	return player_states.get_state_name(state_value)
