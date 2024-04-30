extends CharacterBody2D


const SPEED = 100.0
const ACCELERATION = 600
const FRICTION = 1000
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	# Ui left is the left arrow key and ui right is the right key
	#left adds -1, right adds 1, and neither makes zero
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_animation(input_axis)
	#This method basically takes our velocity and moves the character by the velocity in the direction and slides it against any collisions. Basically as it shows move and slide agaist collisions
	move_and_slide()
	
func apply_gravity(delta):
	# Add the gravity.
	# "Is_on_Floor is a func associated with "CharacterBody2D" (Or previously called KinematicBody2d) which is why we are using it here for gravity
	if not is_on_floor():
		#Positive value is down with the "Y"
		velocity.y += gravity * delta

func handle_jump():
	#"Ui_accept" is th espace key on yhe kayboard
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		
func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
func handle_acceleration(input_axis, delta):
	# This is a shortened vers ion for if "direction != 0" so if we press left or right it will make a positive or ngative value not 0 giving us the direction our playerm oves in
	if input_axis != 0:
		velocity.x = move_toward(velocity.x,  SPEED * input_axis, ACCELERATION * delta)

func update_animation(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("Jump")
