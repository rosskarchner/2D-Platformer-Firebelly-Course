extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	%ContinueButton.connect("pressed", 
		ScreenTransitionManager.transition_to_main)
	


