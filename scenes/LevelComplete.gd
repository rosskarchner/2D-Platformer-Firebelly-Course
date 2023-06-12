extends CanvasLayer

var optionsMenuScene = preload("res://scenes/ui/options_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	%NextLevelButton.connect('pressed', $/root/LevelManager.increment_level)
	%RestartButton.connect('pressed', $/root/LevelManager.restart_level)
	%MainMenuButton.connect('pressed', ScreenTransitionManager.transition_to_main)
