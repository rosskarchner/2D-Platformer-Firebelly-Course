extends Marker2D
class_name EnemySpawner

@export var enemyScene: PackedScene

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction = Direction.RIGHT

var currentEnemyNode 
var spawnOnNextTick = false
var playerNearby = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.connect("timeout", self.on_spawn_timer_timeout)
	if not get_parent().has_node("VisibleOnScreenEnabler2D"):
		spawn_enemy()



func spawn_enemy():
	currentEnemyNode =enemyScene.instantiate()
	currentEnemyNode.startDirection = startDirection
	currentEnemyNode.global_position = global_position
	var gp = global_position
	var egp = currentEnemyNode.global_position
	get_parent().add_sibling.call_deferred(currentEnemyNode)

func check_enemy_spawn():
	if not is_instance_valid(currentEnemyNode):
		if spawnOnNextTick:
			spawn_enemy()
		else:
			spawnOnNextTick = true

func on_spawn_timer_timeout():
		check_enemy_spawn()


func _on_blue_enemy_spawner_tile_ready():
	pass # Replace with function body.
