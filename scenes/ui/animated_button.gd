extends Button

@export var disabledHoverAnim = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if not disabledHoverAnim:
		custom_minimum_size = Vector2(96,24)
		var mouse_entered_func = func():
			$HoverAnimationPlayer.play("hover")
			
		var mouse_exited_func = func():
			$HoverAnimationPlayer.play_backwards("hover")
		
		connect("mouse_entered", mouse_entered_func)
		connect("mouse_entered", mouse_exited_func)	
	var clicked = func():
		$AudioStreamPlayer.play()
		$ClickAnimationPlayer.play("click")
			

	connect("pressed", clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pivot_offset = custom_minimum_size /2
