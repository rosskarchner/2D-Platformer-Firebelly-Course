extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$OptionsMenu.connect(
		"back_pressed", 
		ScreenTransitionManager.transition_to_main
	)
