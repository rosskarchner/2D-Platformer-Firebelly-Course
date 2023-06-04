extends CanvasLayer

signal back_pressed

var fullScreen = (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_mode()
	%WindowModeButton.connect("pressed",
	func():
		fullScreen = !fullScreen
		update_mode()
	)
	
	%BackButton.connect("pressed",
	func():
		emit_signal("back_pressed")
	)

func update_mode():
	if fullScreen:
		%WindowModeButton.text = "Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		%WindowModeButton.text = "Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
