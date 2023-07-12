extends CharacterBody2D

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction = Direction.RIGHT
var isSpawning = true

var enemyDeathScene = preload("res://scenes/enemy_death.tscn")
var maxSpeed = 25

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var directionLookup ={Direction.LEFT: Vector2.LEFT, Direction.RIGHT: Vector2.RIGHT}
@onready var direction = directionLookup[startDirection]

func _ready():
	#$GoalDetector.connect("area_entered", self.on_goal_entered)
	$HitBoxArea.connect("area_entered", self.on_hitbox_enter)

func _physics_process(delta):
	if isSpawning:
		return
	if scale.x == direction.x:
		update_visual_direction()
	
	var player = get_tree().get_first_node_in_group("player")

	#look_at(player.global_position)
	if player:
		self.position = lerp(self.position,player.global_position,.01)
	#move_and_slide()
	if !$Visuals/CliffDetector.is_colliding():
		change_direction()
		
	if $Visuals/WallDetector.is_colliding():
		change_direction()


func update_visual_direction():
	var visuals = $Visuals
	if direction.x > 0:
		visuals.scale.x = -1
	else: 
		visuals.scale.x = 1



func change_direction():
	direction *= -1
	update_visual_direction()



func on_goal_entered(_area2d):
	change_direction()

func on_hitbox_enter(_area2d):
	var scoreKeeper = $"/root/ScoreKeeper"
	scoreKeeper.add_points(40)
	$"/root/Helpers".apply_camera_shake(1.0)
	var myDeathScene = enemyDeathScene.instantiate()
	myDeathScene.global_position = global_position
	if velocity.x > 0:
		myDeathScene.scale = Vector2(-1,0)
	#myDeathScene.get_node("GPUParticles2D").texture=$Visuals/AnimatedSprite2D.
	add_sibling(myDeathScene)
	queue_free()
