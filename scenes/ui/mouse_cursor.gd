extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Sprite2D.global_position = $Sprite2D.get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		$AnimationPlayer.play("click")
