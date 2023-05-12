extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$"%NextLevelButton".connect('pressed', $/root/LevelManager.increment_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
