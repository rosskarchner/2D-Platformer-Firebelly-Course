extends Node

@export var numberToPlay =2
@export var enablePitchRandomization = true
@export var minPitchScale = .9
@export var maxPitchScale = 1.1

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func play():
	var validNodes = []
	for streamPlayer in get_children():
		if not streamPlayer.playing:
			validNodes.append(streamPlayer)

	for i in numberToPlay:
		if validNodes.size() == 0:
			break
		var idx = rng.randi_range(0,validNodes.size()-1)
		if enablePitchRandomization:
			validNodes[idx].pitch_scale = rng.randf_range(minPitchScale,maxPitchScale)
		validNodes[idx].play()
		validNodes.remove_at(idx)
