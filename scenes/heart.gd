extends Node2D
	
func on_area_entered(_area2d):
	$AnimationPlayer.play("pickup")
	$RandomAudioStreamPlayer.play()
	$RandomAudioStreamPlayer2.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	ScoreKeeper.add_life()

func save():
	var save_dict = {
		"pos_x": position.x,
		"pos_y": position.y,
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path()
	}
	return save_dict
