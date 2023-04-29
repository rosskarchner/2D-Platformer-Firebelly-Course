extends CharacterBody2D

enum Direction{RIGHT, LEFT}

@export var startDirection: Direction = Direction.RIGHT

var maxSpeed = 25
@onready var direction = Vector2.RIGHT if startDirection == Direction.RIGHT else Vector2.LEFT
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$GoalDetector.connect("area_entered", self.on_goal_entered)
	$HitBoxArea.connect("area_entered", self.on_hitbox_enter)

func _process(delta):
	velocity.x = (direction * maxSpeed).x
	if !is_on_floor(): 
		velocity.y += gravity * delta
		

	move_and_slide()
	if $TurnAroundTimer.is_stopped() and is_on_floor() and not $CliffDetector.is_colliding():
		change_direction()

	

func change_direction():
	print("direction changed")
	direction *= -1
	var sprite = $AnimatedSprite2D
	var cliffDetector = $CliffDetector
	var timer = $TurnAroundTimer
	sprite.flip_h = direction.x >0
	cliffDetector.position.x = $CliffDetector.position.x * -1
	timer.start()
	print("b")

func on_goal_entered(_area2d):
	change_direction()

func on_hitbox_enter(_area2d):
	queue_free()
