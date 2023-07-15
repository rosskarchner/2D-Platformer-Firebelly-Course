extends Node2D

var shouldDelete = false
var busy = false
var restored_data: Array[Dictionary] = []


func _ready():
	pass # Replace with function body.


func save_game():
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var game_state_data = {
		"level": LevelManager.currentLevelIndex,
		"score": ScoreKeeper.Score,
		"lives": ScoreKeeper.LivesLeft
	}
	var game_state_json_string = JSON.stringify(game_state_data)
	save_game_file.store_line(game_state_json_string)
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_game_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
		
	var levelToLoad = -1
	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.


	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game_file.get_position() < save_game_file.get_length():
		var json_string = save_game_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		if node_data.has("level"):
			levelToLoad = node_data["level"]
			ScoreKeeper.LivesLeft = node_data['lives']
			ScoreKeeper.Score = node_data['score']
		else: 

			restored_data.append(node_data)
	LevelManager.change_level(levelToLoad)
				

func _unhandled_input(event): 
	if event.is_action("save") and event.is_pressed():

		print("saving...")
		save_game()
		get_viewport().set_input_as_handled()
		load_game()

		
	if event.is_action("restore") and event.is_pressed():

		print("restoring...")
		load_game()
		get_viewport().set_input_as_handled()

