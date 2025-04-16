extends CharacterBody2D

var speed = 170
var jump_speed_base = -100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	velocity.y += gravity * delta
	
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = jump_speed_base
		
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_speed_base -= 10  
		$AnimatedSprite2D.animation = "prepare_jump"
		speed = 0
	
	if is_on_floor() and !Input.is_action_pressed("jump"):
		jump_speed_base = -100
		speed = 300
		
	if jump_speed_base <= -700:
		jump_speed_base = -700
	
	
	var direction = Input.get_axis("ui_left","ui_right")
	velocity.x = direction * speed
		
	
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"
		
	if !is_on_floor() and $AnimatedSprite2D.flip_h == true:
		velocity.x = -300
		
	elif !is_on_floor() and $AnimatedSprite2D.flip_h == false:
		velocity.x = 300
	print(velocity.x)
	
	move_and_slide()
	




func _on_area_2d_area_entered(area: Area2D):
	if !is_on_floor() and $AnimatedSprite2D.flip_h == true:
		$AnimatedSprite2D.flip_h = false
	elif !is_on_floor() and $AnimatedSprite2D.flip_h == false:
		$AnimatedSprite2D.flip_h = true
	
	pass # Replace with function body.
