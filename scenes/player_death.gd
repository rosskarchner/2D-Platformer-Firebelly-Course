extends CharacterBody2D


func _ready():		
	$DeathSoundPlayer1.play()
	$DeathSoundPlayer2.play()
	$DeathSoundPlayer3.play()
	if velocity.x > 0:
		$Visuals.scale = Vector2(-1,1)
	

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	move_and_slide()
	
	if is_on_floor(): 
		velocity = lerp(Vector2.ZERO,velocity,pow(2,-1 * delta))
