extends Node

@export var levelScenes: Array[PackedScene]

var currentLevelIndex = 0


func change_level(levelIndex):
	currentLevelIndex = levelIndex
	if currentLevelIndex >= levelScenes.size():
		currentLevelIndex = 0
	get_tree().change_scene_to_packed(levelScenes[currentLevelIndex])

func increment_level():
	change_level(currentLevelIndex + 1)
