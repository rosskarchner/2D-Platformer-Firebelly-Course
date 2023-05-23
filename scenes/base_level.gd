extends Node

signal coin_total_changed

@export var levelCompleteScene: PackedScene

var playerScene = preload("res://scenes/player.tscn")
var spawnPosition = Vector2.ZERO
var currentPlayerNode = null
var totalCoins = 0
var collectedCoins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPosition = %Player.global_position
	register_player(%Player)
	
	coin_total_change(get_tree().get_nodes_in_group("coin").size())
	
	$Flag.connect("player_won", self.on_player_won)
	
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
	$PlayerRoot.call_deferred("add_child", playerInstance)
	register_player(playerInstance)

func on_player_won():
	var levelComplete = levelCompleteScene.instantiate()
	#levelComplete.get_node("%NextLevelButton").connect('pressed', $/root/LevelManager.increment_level)
	add_child(levelComplete)
	currentPlayerNode.queue_free()
	
#func next_level()
	#$"/root/LevelManager".increment_level()

func on_player_died():
	currentPlayerNode.queue_free()
	await get_tree().create_timer(1).timeout

	create_player()
