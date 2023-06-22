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
	%MusicVolumeContainer/RangeControl.connect("percentage_change",
	self.set_bus_volume.bind("Music")
	)
	%SFXVolumeContainer/RangeControl.connect("percentage_change",
	self.set_bus_volume.bind("SFX")
	)
	update_initial_volume_settings()
	
func set_bus_volume(percent, bus_name):
		var busIdx= AudioServer.get_bus_index(bus_name)
		var volumeDb = linear_to_db(percent)
		AudioServer.set_bus_volume_db(busIdx,volumeDb)
	
func update_mode():
	if fullScreen:
		%WindowModeButton.text = "Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		%WindowModeButton.text = "Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func get_bus_volume_percent(bus_name):
	var busIdx = AudioServer.get_bus_index(bus_name)
	var volumePercent = db_to_linear(AudioServer.get_bus_volume_db(busIdx))
	return volumePercent
	
func update_initial_volume_settings():

	%MusicVolumeContainer/RangeControl.set_current_percentage(get_bus_volume_percent("Music"))
	%SFXVolumeContainer/RangeControl.set_current_percentage(get_bus_volume_percent("SFX"))
