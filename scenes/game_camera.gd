extends Camera2D

class_name GameCamera

@export var backgroundColor: Color
@export var shakeNoise: FastNoiseLite
var target_position = Vector2.ZERO

var xNoiseSampleVector = Vector2.RIGHT
var yNoiseSampleVector = Vector2.DOWN
var xNoiseSamplePosition = Vector2.ZERO
var yNoiseSamplePosition = Vector2.ZERO
var noiseSampleTravelRate = 500
var maxShakeOffeset = 10
var shakeDecay = 3

var currentShakePercentage = 0

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor)
  


func _process(delta):
	acquire_target_position()
	global_position = target_position

	
	if currentShakePercentage > 0:
		xNoiseSamplePosition += xNoiseSampleVector * delta * noiseSampleTravelRate
		yNoiseSamplePosition += yNoiseSampleVector * delta * noiseSampleTravelRate
		var xSample = shakeNoise.get_noise_2dv(xNoiseSamplePosition)
		var ySample = shakeNoise.get_noise_2dv(yNoiseSamplePosition)
		
		var calculatedOffset = Vector2(xSample,ySample) * maxShakeOffeset * pow(currentShakePercentage, 2)
		offset = calculatedOffset
		
		currentShakePercentage = clamp(currentShakePercentage - (shakeDecay * delta), 0, 1.0)
		
func apply_shake(percentage):
	currentShakePercentage=  clamp(currentShakePercentage+ percentage, 0 ,1)

func acquire_target_position():
	get_target_position_from_node_group("player") or get_target_position_from_node_group("player_death")

func get_target_position_from_node_group(group_name):
	var found_nodes = get_tree().get_nodes_in_group(group_name)
	if len(found_nodes) > 0:
		target_position = found_nodes[0].global_position
		return true
	else:
		return false
