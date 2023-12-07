extends Node
class_name Movable

var _next_move: PlayerStateRessource.EnumState
var _direction: Vector2 = Vector2(0,0)


func get_movement_direction() -> Vector2:
	return _direction

func set_movement_direction(new_direction: Vector2):
	_direction = new_direction.normalized()


func set_next_move(new_move: PlayerStateRessource.EnumState):
	_next_move = new_move

func get_next_move() -> PlayerStateRessource.EnumState:
	return _next_move
