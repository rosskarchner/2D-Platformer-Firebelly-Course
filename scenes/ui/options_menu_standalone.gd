extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$OptionsMenu.connect(
		"back_pressed", 
		ScreenTransitionManager.transition_to_main
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
