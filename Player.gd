extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_jump
var coyote_time = 0
var is_in_wall
var jumped_while_on_wall
signal hit
signal spearThrow

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func playerPhysics(delta):
	if not is_on_floor():
		if is_in_wall == true:
			velocity.y += 980 * delta
		else:
			velocity.y += gravity * delta
			coyote_time -= delta;
			can_jump = 0
	else:
		can_jump = 1
		coyote_time = 0.1

func spearThrowing():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		spearThrow.emit()
		
		
func animations():
	if is_on_floor() == false and is_on_wall() == false:
		if velocity.y > 0 and Points.lancaState == true:
			$AnimatedSprite2D.animation = "falling"
		elif velocity.y > 0 and Points.lancaState == false:
			$AnimatedSprite2D.animation = "falling_noSpear"
		elif velocity.y < 0 and Points.lancaState == true:
			$AnimatedSprite2D.animation = "jumping"
		elif velocity.y < 0 and Points.lancaState == false:
			$AnimatedSprite2D.animation = "jumping_noSpear"
			
	if $AnimatedSprite2D.animation == "falling" and $AnimatedSprite2D.frame == 2:
		$AnimatedSprite2D.frame = 2
		if is_on_floor() and $AnimatedSprite2D.frame == 2:
			$AnimatedSprite2D.frame = 3
	if $AnimatedSprite2D.animation == "falling_noSpear" and $AnimatedSprite2D.frame == 2:
		$AnimatedSprite2D.frame = 2
		if is_on_floor() and $AnimatedSprite2D.frame == 2:
			$AnimatedSprite2D.frame = 3
	if $AnimatedSprite2D.animation == "jumping" and $AnimatedSprite2D.frame == 2:
		$AnimatedSprite2D.frame = 2
	if $AnimatedSprite2D.animation == "jumping_noSpear" and $AnimatedSprite2D.frame == 2:
		$AnimatedSprite2D.frame = 2
		
		
func jump(delta):
	if can_jump > 0 or coyote_time > 0:
		if Input.is_action_just_pressed("ui_accept"):
			if is_in_wall and Input.is_action_pressed("ui_left"):
				velocity.x = 125*delta*SPEED
				velocity.y = JUMP_VELOCITY
			elif is_in_wall and Input.is_action_pressed("ui_right"):
				velocity.x = -125*delta*SPEED
				velocity.y = JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY


func wall_grip(delta):
	if is_on_wall() and not is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			is_in_wall = true
			can_jump = 1
		else:
			is_in_wall = false
	else:
		is_in_wall = false


func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if is_on_floor():
			if Points.lancaState == true:
				$AnimatedSprite2D.animation = "walking"
			else:
				$AnimatedSprite2D.animation = "walking_noSpear"
			$AnimatedSprite2D.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if Points.lancaState == true:
			$AnimatedSprite2D.animation = "default"
		else:
			$AnimatedSprite2D.animation = "default_noSpear"
	playerPhysics(delta)

	jump(delta)

	wall_grip(delta)

	animations()



	spearThrowing()

	move_and_slide()


