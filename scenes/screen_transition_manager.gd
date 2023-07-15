extends Node

signal transition_complete

var screenTransitionScene = preload("res://scenes/ui/screen_transition.tscn")


func transition_to_scene(scene):
	for button in get_tree().get_nodes_in_group("animated_button"):
		button.disabled = true
	await get_tree().create_timer(.2).timeout
	var screenTransition = screenTransitionScene.instantiate()
	add_child(screenTransition)
	await screenTransition.screen_covered
	get_tree().change_scene_to_packed(scene)

func transition_to_main():
	ScreenTransitionManager.transition_to_scene(
					preload("res://scenes/ui/main_menu.tscn")
				)

func transition_to_end():
	ScreenTransitionManager.transition_to_scene(
					preload("res://scenes/ui/game_complete.tscn")
				)

func transition_to_options():
	ScreenTransitionManager.transition_to_scene(
					preload("res://scenes/ui/options_menu_standalone.tscn")
				)
