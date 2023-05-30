extends CanvasLayer

@onready var playButton = %PlayButton
@onready var OptionsButton = %OptionsButton
@onready var quitButton = %QuitButton


# Called when the node enters the scene tree for the first time.
func _ready():
	playButton.connect("pressed", func():
		$/root/LevelManager.change_level(0)

	)
	quitButton.connect("pressed", func():
		get_tree().quit()
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
