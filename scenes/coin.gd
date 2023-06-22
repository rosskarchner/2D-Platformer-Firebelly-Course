extends Node2D

@onready var baseLevel = get_tree().get_nodes_in_group("base_level")[0]

func _ready():
	baseLevel.update_coin_total()
	
func on_area_entered(_area2d):
	$AnimationPlayer.play("pickup")
	$RandomAudioStreamPlayer.play()
	$RandomAudioStreamPlayer2.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	ScoreKeeper.add_points(1)
	
	baseLevel.coin_collected()
