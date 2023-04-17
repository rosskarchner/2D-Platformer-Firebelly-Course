extends CharacterBody2D


const SPEED = 100
const MAX_HORIZONTAL_SPEED = 150
const JUMP_VELOCITY = -360.0
const ACCELERATION_PER_SEC = 150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Is this a dumb way to do this?
var current_acceleration = 0.0
var last_direction = 0
var jump_termination_multiplyser = 4

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		current_acceleration = 0.0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if velocity.y < 0 and not Input.is_action_pressed("ui_accept"):
		velocity.y += gravity * jump_termination_multiplyser * delta
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		if direction != last_direction:
			current_acceleration = 0.0
		else:
			current_acceleration += ACCELERATION_PER_SEC * delta
		velocity.x = direction * clamp(SPEED + current_acceleration, 0 ,MAX_HORIZONTAL_SPEED)
		last_direction = direction
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		current_acceleration = 0.0

	move_and_slide()
	update_animation(direction)

func update_animation(direction):
	if not is_on_floor(): 
		$AnimatedSprite2D.play("jump")
	
	elif direction != 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction > 0
		
	else:
		$AnimatedSprite2D.play("idle")
		
	
		

