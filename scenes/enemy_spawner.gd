extends Marker2D

@export var enemyScene: PackedScene

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction = Direction.RIGHT

var currentEnemyNode 
var spawnOnNextTick = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.connect("timeout", self.on_spawn_timer_timeout)
	call_deferred("spawn_enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy():
	currentEnemyNode =enemyScene.instantiate()
	currentEnemyNode.startDirection = startDirection
	currentEnemyNode.global_position = global_position
	get_parent().add_child(currentEnemyNode)

func check_enemy_spawn():
	if not is_instance_valid(currentEnemyNode):
		if spawnOnNextTick:
			spawn_enemy()
		else:
			spawnOnNextTick = true

func on_spawn_timer_timeout():
	check_enemy_spawn()
