extends Node2D

	
func on_area_entered(_area2d):
	$AnimationPlayer.play("pickup")
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

