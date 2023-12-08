extends Node2D
class_name PlayerHand

@export var initial_cards: Array[PlayerStateRessource.EnumState]
@export var player: Player
@export var battlefield: Battlefield

var card_scene = preload("res://entities/cards/card.tscn")


func _ready():
	for card_effect in initial_cards:
		var card_instance = card_scene.instantiate()
		card_instance.init(card_effect, player, battlefield)
		card_instance.global_position = $CardsPositions/Marker2D.global_position
		add_child(card_instance)
