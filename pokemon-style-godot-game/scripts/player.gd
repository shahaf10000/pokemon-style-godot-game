extends CharacterBody3D

@export var speed := 5.0
@export var gravity := 20.0

func _physics_process(_delta): # function to process physics every frame
	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1
	
	if Input.is_action_pressed("ui_down")	:
		input_dir.z += 1
	
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	
	input_dir = input_dir.normalized() # fixing the momvent speed if two button are pressed at the same time
	
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed
	
	velocity.y -= gravity * _delta
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = gravity / 3
	
	#var pos = global_transform.origin # kill switch for y = 0
	#if pos.y < 0 and velocity.y < 0:
		#pos.y = 0
		#velocity.y = 0
		#global_transform.origin = pos
	
	move_and_slide() # actually moving the player
