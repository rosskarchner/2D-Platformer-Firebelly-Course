extends Camera2D

class_name GameCamera

@export var backgroundColor: Color
var target_position = Vector2.ZERO

func _ready():
	RenderingServer.set_default_clear_color(backgroundColor)


func _process(_delta):
	acquire_target_position()
	global_position = target_position

func acquire_target_position():
	var players = get_tree().get_nodes_in_group("player")
	
	if len(players) > 0:
		var player = players[0]
		target_position = player.global_position
