extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var baseLevels = get_tree().get_nodes_in_group("base_level")
	
	if baseLevels.size() > 0 :
		baseLevels[0].connect("coin_total_changed", self.on_coin_total_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_coin_total_change(totalCoins, collectedCoins):
	$MarginContainer/HBoxContainer/CoinLabel.text = str(collectedCoins, " / ", totalCoins)
	
