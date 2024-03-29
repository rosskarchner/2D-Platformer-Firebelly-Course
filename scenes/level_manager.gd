extends Node

@export var levelScenes: Array[PackedScene]

var currentLevelIndex = 0
var nextLevelPacked: PackedScene


func change_level(levelIndex =0):
	currentLevelIndex = levelIndex
	if currentLevelIndex >= levelScenes.size():
		ScreenTransitionManager.transition_to_end()
	else:
		ScreenTransitionManager.transition_to_scene(levelScenes[currentLevelIndex])
		nextLevelPacked = levelScenes[currentLevelIndex+1]
		

func increment_level():
	change_level(currentLevelIndex + 1)

func restart_level():
	change_level(currentLevelIndex)
	
func _process(_delta):
	if Input.is_action_just_pressed("skip_level"):
		increment_level()

