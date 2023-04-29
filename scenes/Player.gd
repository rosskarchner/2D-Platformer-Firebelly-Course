extends CharacterBody2D

signal died

@export_flags_2d_physics var dashHazardMask
enum State {NORMAL, DASHING}

const SPEED = 100
const MAX_HORIZONTAL_SPEED = 150
const JUMP_VELOCITY = -320.0
const ACCELERATION_PER_SEC = 150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Is this a dumb way to do this?
var current_acceleration = 0.0
var last_direction = 1
var jump_termination_multiplyser = 4
var has_double_jump = false
var has_dash = false
var currentState = State.NORMAL
var maxDashSpeed =  500
var minDashSpeed = 200
var isStateNew = true
var defaultHazardMask

func _ready():
	$HazardArea.connect("area_entered", self.on_hazard_area_entered)
	defaultHazardMask = $HazardArea.collision_mask
	
	
func _physics_process(delta):
	match currentState:
		State.NORMAL:
			physics_process_normal(delta)
		State.DASHING:
			physics_process_dashing(delta)
	isStateNew = false


func change_state(newState):
	currentState = newState
	isStateNew = true
	
func physics_process_normal(delta):
	if isStateNew:
		$DashArea/CollisionShape2D.disabled = true
		$HazardArea.collision_mask = defaultHazardMask
	
		# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		current_acceleration = 0.0
	else:
		has_double_jump = true
		has_dash = true

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and (( is_on_floor() or not $CoyoteTimer.is_stopped()) or has_double_jump):
		velocity.y = JUMP_VELOCITY
		
		if !is_on_floor() && $CoyoteTimer.is_stopped():
			has_double_jump = false
		$CoyoteTimer.stop()
		
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

	var wasOnFloor = is_on_floor()
	move_and_slide()
	update_animation(direction)
	
	if wasOnFloor and !is_on_floor():
		$CoyoteTimer.start()
		
	if has_dash and Input.is_action_just_pressed("dash"):
		call_deferred("change_state", State.DASHING)
		has_dash=false

func physics_process_dashing(delta):
	if isStateNew:
		velocity = Vector2(maxDashSpeed * last_direction , 0.0) 
		$DashArea/CollisionShape2D.disabled = false
		$HazardArea.collision_mask = dashHazardMask
	move_and_slide()


	velocity.x = lerpf(0, velocity.x, pow(2.0,-8.0 * delta))
	
	if abs(velocity.x) < minDashSpeed:
		call_deferred("change_state", State.NORMAL)
		
	update_animation(last_direction)
		

func update_animation(direction):
	if not is_on_floor() or currentState == State.DASHING: 
		$AnimatedSprite2D.play("jump")
	
	elif direction != 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction > 0
		
	else:
		$AnimatedSprite2D.play("idle")
		
	
		
func on_hazard_area_entered(_area2d):
	emit_signal("died")
	

