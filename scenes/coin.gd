extends Node2D

	
func on_area_entered(_area2d):
	$AnimationPlayer.play("pickup")
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

	var baseLevel = get_tree().get_nodes_in_group("base_level")[0]
	baseLevel.coin_collected()
