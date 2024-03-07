extends KinematicBody2D

onready var timer =  $Timer
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var dir = Vector2.ZERO
var speed =100
var is_pushed = false

var prev
var now =is_on_floor()

func _process(delta):
	prev = now
	now = is_on_floor()
	if not is_on_floor() and velocity.y>0:
		$AnimatedSprite.play("fall")
		print(str(prev)+" "+str(now))
	
	if now and not prev:
		print(now and not prev)
		$fall.play()
	
	velocity.y += delta * 300
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if not is_pushed and velocity.x ==0 and velocity.y==0:
		$AnimatedSprite.play("default")
	if is_pushed and velocity!=Vector2.ZERO:
		velocity.x = move_toward(velocity.x, 0, 20)
		velocity.y = move_toward(velocity.y, 0, 20)
		move_and_slide(velocity)
		if velocity.x ==0 and velocity.y==0:
			is_pushed=false

func _on_Timer_timeout():
	if not is_pushed and is_on_floor():
		
		dir = Vector2(rng.randi_range(-1,1),0)
		if dir.x<0:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h=true
		elif dir.x>0:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h=false
		else :
			$AnimatedSprite.play("default")
		velocity = dir*speed
		print(velocity)

func interact(source): 
	is_pushed = true
	velocity = 2000*Vector2.UP
	$AnimatedSprite.play("yeet")
