extends CharacterBody3D

@export var speed := 10.0
@export var gravity := 20.0

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
		
	if Input.is_action_just_pressed("ui_end"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-30), deg_to_rad(30))
	
	twist_input = 0
	pitch_input = 0
	
	var direction = twist_pivot.global_transform.basis * input_dir
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= gravity * _delta
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = gravity / 2
	
	move_and_slide() # actually moving the player

func _unhandled_input(event: InputEvent) -> void:
	if event is  InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
