extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var scoreKeeper = $"/root/ScoreKeeper"
	scoreKeeper.connect("points_updated", self.update_score)
	%ScoreLabel.text = str(scoreKeeper.Score)
	


func update_score():
	%ScoreLabel.text = str($"/root/ScoreKeeper".Score)
