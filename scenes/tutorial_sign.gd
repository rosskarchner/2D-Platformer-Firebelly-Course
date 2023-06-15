extends Node2D

@export_multiline var text = "Change me"

# Called when the node enters the scene tree for the first time.
func _ready():
	%Label.text = text
	$PanelContainer.visible = false
	$Area2D.connect("area_entered", func(_collider):
		$PanelContainer.visible = true
		$Sprite2D.frame = 1
	)
	$Area2D.connect("area_exited", func(_collider):
		$PanelContainer.visible = false
		$Sprite2D.frame = 0
		pass
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

