extends HBoxContainer

signal percentage_change

var currentPercentage = 1.0

func _ready():
	$SubtractButton.connect("pressed", self.change_by_percent.bind(-0.1) )
	$AddButton.connect("pressed", self.change_by_percent.bind(0.1) )
	
func change_by_percent(change):
	set_current_percentage(currentPercentage + change)

func set_current_percentage(percent):
	currentPercentage= clamp(percent, 0 ,1)
	emit_signal("percentage_change", currentPercentage)
	$Label.text = str(round(currentPercentage * 10))
