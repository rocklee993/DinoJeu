extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const JUMP_VELOCITY = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2500


func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer2D.play()
		
	if Input.is_action_pressed("down") and is_on_floor():
		anim.play("crouch")
	else:
		anim.play("idle")	


	move_and_slide()
