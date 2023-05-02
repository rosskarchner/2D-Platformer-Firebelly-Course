extends Node

signal coin_total_changed

var playerScene = preload("res://scenes/player.tscn")
var spawnPosition = Vector2.ZERO
var currentPlayerNode = null
var totalCoins = 0
var collectedCoins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPosition = $Player.global_position
	register_player($Player)
	
	coin_total_change(get_tree().get_nodes_in_group("coin").size())
	
func coin_collected():
	collectedCoins += 1
	emit_signal("coin_total_changed", totalCoins, collectedCoins)
	
func coin_total_change(newTotal):
	totalCoins = newTotal
	emit_signal("coin_total_changed", totalCoins, collectedCoins)
	
func register_player(player):
	currentPlayerNode = player
	currentPlayerNode.connect("died", self.on_player_died)
	
func create_player():
	var playerInstance = playerScene.instantiate()
	playerInstance.set_deferred("global_position", spawnPosition)
	currentPlayerNode.call_deferred("add_sibling", playerInstance)
	register_player(playerInstance)

func on_player_died():
	currentPlayerNode.queue_free()
	create_player()
