extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var scoreKeeper = $"/root/ScoreKeeper"
	scoreKeeper.connect("points_updated", self.update_score)
	scoreKeeper.connect("lives_updated", self.update_lives)
	%LivesLeftLabel.text = str(ScoreKeeper.LivesLeft)
	%ScoreLabel.text = str(scoreKeeper.Score)
	
func update_lives():
	%LivesLeftLabel.text = str(ScoreKeeper.LivesLeft)

func update_score():
	%ScoreLabel.text = str($"/root/ScoreKeeper".Score)
