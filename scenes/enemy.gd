extends CharacterBody2D

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction

var maxSpeed = 25
@onready var direction = Vector2.RIGHT if startDirection == Direction.RIGHT else Vector2.LEFT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$GoalDetector.connect("area_entered", self.on_goal_entered)

func _process(delta):
	velocity.x = (direction * maxSpeed).x
	if !is_on_floor(): 
		velocity.y += gravity * delta
		
	if is_on_wall():
		direction *= -1
	move_and_slide()

	$AnimatedSprite2D.flip_h = direction.x > 0

func on_goal_entered(_area2d):
	direction *= -1
