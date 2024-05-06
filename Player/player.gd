extends CharacterBody2D

#We connected our resource through this making it so instead of setting up fvalues here we did it here
@export var movement_data : PlayerMovementData

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	# Ui left is the left arrow key and ui right is the right key
	#left adds -1, right adds 1, and neither makes zero
	var input_axis = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animation(input_axis)
	#This variaible is placed to chack to see if the player was on the floor before we move
	var was_on_floor = is_on_floor()
	#This method basically takes our velocity and moves the character by the velocity in the direction and slides it against any collisions. Basically as it shows move and slide agaist collisions
	move_and_slide()
	
	#This checks if the character is sill on the floor after moving 
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	
	if just_left_ledge:
		coyote_jump_timer.start()

func apply_gravity(delta):
	# Add the gravity.
	# "Is_on_Floor is a func associated with "CharacterBody2D" (Or previously called KinematicBody2d) which is why we are using it here for gravity
	if not is_on_floor():
		#Positive value is down with the "Y"
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_jump():
	#"Ui_accept" is th espace key on yhe kayboard
	#The "Coyote_Jump_Timer"  checks if it's greater than 0 as well so we know that we can jump either on the floor or at a slight grace period after jumping
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = movement_data.JUMP_VELOCITY
	#This is to checked to see if we are not on lthe floor then we can shorten the jump
	if not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < movement_data.JUMP_VELOCITY / 2:
			velocity.y = movement_data.JUMP_VELOCITY / 2
		
func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.FRICTION * delta)
	
#When player jumps they slowdown in the air like being blown by air
func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)
		
func handle_acceleration(input_axis, delta):
	# This is a shortened vers ion for if "direction != 0" so if we press left or right it will make a positive or ngative value not 0 giving us the direction our playerm oves in
	if input_axis != 0:
		velocity.x = move_toward(velocity.x,  movement_data.SPEED * input_axis, movement_data.ACCELERATION * delta)

func update_animation(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	
	if not is_on_floor():
		animated_sprite_2d.play("Jump")