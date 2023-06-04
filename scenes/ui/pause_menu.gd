extends CanvasLayer

@onready var mainMenuScene = preload("res://scenes/ui/main_menu.tscn")

var optionsMenuScene = preload("res://scenes/ui/options_menu.tscn")

func _ready():
	get_tree().paused=true

func unpause():
	queue_free()
	get_tree().paused=false

func _on_continue_button_pressed():
	unpause()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		unpause()
		get_viewport().set_input_as_handled()

func _on_options_button_pressed():
	var optionsMenuInstance = optionsMenuScene.instantiate()
	optionsMenuInstance.connect("back_pressed", func():
		optionsMenuInstance.queue_free()
		$MarginContainer.visible = true
		)
	$MarginContainer.visible = false
	add_child(optionsMenuInstance)



func _on_quit_button_pressed():
	ScreenTransitionManager.transition_to_main()
	unpause()
