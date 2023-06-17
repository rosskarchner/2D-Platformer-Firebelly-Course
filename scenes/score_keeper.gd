extends Node

signal points_updated

var Score = 0

func add_points(new_points):
	Score += new_points
	emit_signal("points_updated")


func spend_points(spent_points):
	Score -= spent_points
	emit_signal("points_updated")
