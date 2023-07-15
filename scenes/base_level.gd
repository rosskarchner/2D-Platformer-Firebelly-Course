extends Node

signal coin_total_changed

@export var levelCompleteScene: PackedScene

var playerScene = preload("res://scenes/player.tscn")
var pauseScene = preload("res://scenes/ui/pause_menu.tscn")
var spawnPosition = Vector2.ZERO
var currentPlayerNode = null
var totalCoins = 0
var collectedCoins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPosition = %Player.global_position
	if SaveGameManager.restored_data:
		var persistNodes = get_tree().get_nodes_in_group("Persist")
		await get_tree().create_timer(.2).timeout 
		for i in persistNodes:
				print(i)
				i.queue_free()
				
		for node_data in SaveGameManager.restored_data:
			var new_object = load(node_data["filename"]).instantiate()
			get_node(node_data["parent"]).add_child(new_object)
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])	
			# Now we set the remaining variables.
			for i in node_data.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
					continue
				new_object.set(i, node_data[i])
		
	SaveGameManager.restored_data.resize(0)
	register_player(%Player)
	update_coin_total()
	$Flag.connect("player_won", self.on_player_won)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		var pauseMenu = pauseScene.instantiate()
		add_child(pauseMenu)

func update_coin_total():
	coin_total_change(get_tree().get_nodes_in_group("coin").size())
	
func coin_collected():
	collectedCoins += 1
	emit_signal("coin_total_changed", totalCoins, collectedCoins)
	if collectedCoins == totalCoins:
		$Flag.activate()
	
func coin_total_change(newTotal):
	totalCoins = newTotal
	emit_signal("coin_total_changed", totalCoins, collectedCoins)
	
func register_player(player):
	currentPlayerNode = player
	currentPlayerNode.connect("died", self.on_player_died)
	
func create_player():
	var playerInstance = playerScene.instantiate()
	playerInstance.set_deferred("global_position", spawnPosition)
	call_deferred("add_child", playerInstance)
	register_player(playerInstance)

func on_player_won():
	currentPlayerNode.disable_player_input()
	var levelComplete = levelCompleteScene.instantiate()
	#levelComplete.get_node("%NextLevelButton").connect('pressed', $/root/LevelManager.increment_level)
	add_child(levelComplete)
	
	
#func next_level()
	#$"/root/LevelManager".increment_level()

func on_player_died():
	currentPlayerNode.queue_free()
	await get_tree().create_timer(1).timeout

	create_player()
