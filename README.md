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
