extends CanvasLayer

@onready var playButton = %PlayButton
@onready var OptionsButton = %OptionsButton
@onready var quitButton = %QuitButton


# Called when the node enters the scene tree for the first time.
func _ready():
	playButton.connect("pressed", LevelManager.change_level)
	quitButton.connect("pressed", get_tree().quit)
	OptionsButton.connect("pressed", ScreenTransitionManager.transition_to_options)

