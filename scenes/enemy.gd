extends CharacterBody2D

class_name Enemy

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction = Direction.RIGHT
@export var canJump = false
@export var detectCliff = true
@export var detectWall = true
@export var enemyDeathScene: PackedScene

var isSpawning = true
var maxSpeed = 25

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var directionLookup ={Direction.LEFT: Vector2.LEFT, Direction.RIGHT: Vector2.RIGHT}
@onready var direction = directionLookup[startDirection]

func _ready():
	$HitBoxArea.connect("area_entered", self.on_hitbox_enter)

func _process(delta):
	if isSpawning:
		return
	if scale.x == direction.x:
		update_visual_direction()
		
	velocity.x = (direction * maxSpeed).x
	if !is_on_floor(): 
		velocity.y += gravity * delta
	
	
	if canJump and $Visuals/WallDetector.is_colliding() and !$"Visuals/Can Jump Detecter".is_colliding():
		jump()
		
	move_and_slide()
	
	
	if  detectCliff and !$Visuals/CliffDetector.is_colliding():
		change_direction()
		
	if detectWall and $Visuals/WallDetector.is_colliding():
		change_direction()


func jump():
	velocity.y = -300

func update_visual_direction():
	var visuals = $Visuals
	if direction.x > 0:
		visuals.scale.x = -1
	else: 
		visuals.scale.x = 1



func change_direction():
	direction *= -1
	update_visual_direction()
	if canJump:
		jump()



func on_hitbox_enter(_area2d):
	var scoreKeeper = $"/root/ScoreKeeper"
	scoreKeeper.add_points(5)
	$"/root/Helpers".apply_camera_shake(1.0)
	var myDeathScene = enemyDeathScene.instantiate()
	myDeathScene.global_position = global_position
	if velocity.x > 0:
		myDeathScene.scale = Vector2(-1,0)
	add_sibling(myDeathScene)
	queue_free()
