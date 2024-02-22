extends KinematicBody2D
export (int) var speed = 400

export (int) var GRAVITY = 1200
export (int) var jump_speed = -400

var has_double_jumped= false
var  is_dashing=false
var timer_dash_right = 0
var timer_dash_left = 0
var can_dash=false

onready var animatedAprite = $AnimatedSprite

const UP = Vector2(0,-1)

var velocity = Vector2()

func get_input():
	if velocity.x==0 and is_on_floor():
		animatedAprite.play("default")
	velocity.x=0
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		has_double_jumped=false
		velocity.y = jump_speed
	elif not is_on_floor() and  velocity.y>=0 and Input.is_action_just_pressed("ui_up") and not has_double_jumped:
		has_double_jumped=true
		velocity.y = jump_speed
	if Input.is_action_pressed('ui_right'):
#		print("right")
		velocity.x += speed
		animatedAprite.play("walk")
		animatedAprite.flip_h=false
		if Input.is_action_just_pressed("ui_right") and timer_dash_right>0:
			print("dash")
			velocity.x=speed*5
			
	if Input.is_action_just_released("ui_right"):
		print("release")
		timer_dash_right=0.2

	if Input.is_action_pressed('ui_left'):
		velocity.x -= speed
		animatedAprite.play("walk")
		animatedAprite.flip_h=true
		if Input.is_action_just_pressed("ui_left") and timer_dash_left>0:
			print("dash")
			velocity.x=speed*-5
			
	if Input.is_action_just_released("ui_left"):
		print("release")
		timer_dash_left=0.2
		
	if Input.is_action_pressed("ui_down"):
		animatedAprite.play("duck")
		
	if not is_on_floor() and velocity.y>=0 :
		animatedAprite.play("fall")
	elif not is_on_floor() and velocity.y<0:
		animatedAprite.play("jump")

func _process(delta):
	timer_dash_right-=delta
	timer_dash_left-=delta

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
