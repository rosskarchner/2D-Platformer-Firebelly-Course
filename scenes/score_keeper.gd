extends Node

signal points_updated
signal lives_updated


var Score = 0
var LivesLeft= 30


func add_points(new_points):
	Score += new_points
	emit_signal("points_updated")

func spend_points(spent_points):
	Score -= spent_points
	emit_signal("points_updated")

func add_life():
	LivesLeft += 1
	emit_signal("lives_updated")


func lose_life():
	LivesLeft -= 1
	emit_signal("lives_updated")
	if LivesLeft < 1:
		ScreenTransitionManager.transition_to_main()
