extends Node

var screenTransitionScene = preload("res://scenes/ui/screen_transition.tscn")


func transition_to_scene(scene):
	var screenTransition = screenTransitionScene.instantiate()
	add_child(screenTransition)
	await screenTransition.screen_covered
	get_tree().change_scene_to_packed(scene)
