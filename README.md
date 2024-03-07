Fitur yang saya tambahkan :
Untuk menambahkan fitur double jump saya menambahkan kode berikut:
```
var has_double_jumped= false
...
```
dan kode berikut pada method get_input:
```
if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		has_double_jumped=false
		velocity.y = jump_speed
	elif not is_on_floor() and  velocity.y>=0 and Input.is_action_just_pressed("ui_up") and not has_double_jumped:
		has_double_jumped=true
		velocity.y = jump_speed
```
Untuk fitur duck cukup menambahkan kode berikut pada method get_input:
```
	if Input.is_action_pressed("ui_down"):
		animatedAprite.play("duck")
```
dan yang terakhir untuk dash saya menambahkan kode berikut sebagai global variabel :
```
var timer_dash_right = 0
var timer_dash_left = 0
var can_dash=false
```
dan pada get_input deteksi move saya ubah agar memproses dash juga:
```
if Input.is_action_pressed('ui_right'):
#		print("right")
		velocity.x += speed
		animatedAprite.play("walk")
		animatedAprite.flip_h=false
		if Input.is_action_just_pressed("ui_right") and timer_dash_right>0:
			print("dash")
			velocity.x=speed*10
			
	if Input.is_action_just_released("ui_right"):
		print("release")
		timer_dash_right=0.2

	if Input.is_action_pressed('ui_left'):
		velocity.x -= speed
		animatedAprite.play("walk")
		animatedAprite.flip_h=true
		if Input.is_action_just_pressed("ui_left") and timer_dash_left>0:
			print("dash")
			velocity.x=speed*-10
			
	if Input.is_action_just_released("ui_left"):
		print("release")
		timer_dash_left=0.2
```

### Tutorial 5
Pada tutorial ini karena sudah diimplementasikan animation player pada bonus tutorial 3 maka implementasi tersebut sudah ada. Selain itu, untuk mengimplementasikan fitur-fitur exercise saya membuat scene robot.tscn yang memiliki struktur berikut 
![image](https://github.com/KenKomKom/gamedev-tutorial-3/assets/119410845/5ae5a282-b717-49d2-9d93-b3e5f58d56bb)

Kode yang dibuat adalah sebagai berikut pada script scene robot agar robot bisa bergerak dan juga berinteraksi dengan player. Selain itu perlu dipahami juga kalau robot berfungsi sebagai background music player sehingga saat player berinteraksi dengannya akan berpengaruh terhadap kekerasan suara background.
```
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
```
Sedangkan untuk kita tambahkan juga kode berikut untuk menghandle interaksi antar robot dan player
```
func interact():
	var around = push_area.get_overlapping_bodies()
	for e in around:
		if "robot" in e.name:
			e.interact(self.global_position)
	$AudioStreamPlayer.play()
```
Dimana artinya kita perlu menambahkan node AudioStreamPlayer ke scene player sehingga bisa memainkan audio yang kita inginkan untuk interaksinya.

Berikut link audio yang saya gunakan yang saya dapatkan dari Youtube:
- https://www.youtube.com/watch?v=l6d90wgYbrE
- https://www.youtube.com/watch?v=M0JY7X_a82E
