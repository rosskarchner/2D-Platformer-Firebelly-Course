extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
		var busIdx= AudioServer.get_bus_index("Music")
		var volumeDb = linear_to_db(0.7)
		AudioServer.set_bus_volume_db(busIdx,volumeDb)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
