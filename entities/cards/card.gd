extends CharacterBody2D
class_name Card

signal card_clicked(card: Card)

@export var state_effect: PlayerStateRessource.EnumState
var player: Player
var battlefield: Battlefield

var info: CardInformation
var can_interact: bool = true
var mouse_in: bool = false
var selected: bool = false
var dragging: bool = false
var in_battlefield: bool = false

var dragging_distance: float = 0.0
var direction: Vector2 = Vector2(0,0)
var target_dragged_position: Vector2 = Vector2(0,0)


func init(card_effect: PlayerStateRessource.EnumState, controlled_player: Player, active_battlefield: Battlefield) -> void:
	state_effect = card_effect
	player = controlled_player
	battlefield = active_battlefield
	info = CardInformation.new(card_effect)
	var image = Image.new()
	image.load(info.sprite_path)
	var texture = ImageTexture.create_from_image(image)
	$Sprite2D.texture = texture
	$Control/Title.set_text(info.title)
	$Control/Description.set_text(info.description)


func _input(event: InputEvent):
	if not can_interact: return
	if event is InputEventMouseButton:
		if event.is_pressed() and mouse_in:
			dragging_distance = position.distance_to(get_viewport().get_mouse_position())
			direction = (get_viewport().get_mouse_position() - position).normalized()
			target_dragged_position = get_viewport().get_mouse_position() - dragging_distance * direction
			$BattlefieldDetectionArea.position = get_local_mouse_position()
			selected = true
			dragging = true
		elif event.is_released() and selected and dragging:
			$BattlefieldDetectionArea.position = Vector2(0,0)
			if in_battlefield:
				can_interact = false
				$AnimationPlayer.play("activate")
			selected = false
			dragging = false
		else:
			selected = false
			dragging = false
	
	elif event is InputEventMouseMotion:
		if dragging:
			target_dragged_position = get_viewport().get_mouse_position() - dragging_distance * direction


func _physics_process(delta: float):
	if dragging:
		velocity = (target_dragged_position - position) / delta
		move_and_slide()


func activate_effect():
	player.move_component.set_next_move(state_effect)


func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false


func _on_battlefield_detection_area_area_entered(area):
	in_battlefield = true


func _on_battlefield_detection_area_area_exited(area):
	in_battlefield = false
