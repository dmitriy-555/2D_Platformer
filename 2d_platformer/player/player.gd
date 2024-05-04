extends KinematicBody2D

var velosity = Vector2()
const speed = 105
var gravity = 13
const jump = 250
const FLOOR = Vector2(0,0)
var combopoints_sword = 3
var combopoints_axe = 3

func _physics_process(delta):
	if $AnimationPlayer.current_animation == "death":
		return
	if $Sprite.flip_h == true:
		$Sprite/SwordHit/CollisionShape2D.position.x = 23
	else: 
		$Sprite/SwordHit/CollisionShape2D.position.x = -23
	if Input.is_action_just_pressed("attack_sword") && combopoints_sword == 3 && $AnimationPlayer.current_animation != "axe_attack1" && $AnimationPlayer.current_animation != "axe_attack2" && $AnimationPlayer.current_animation != "axe_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 1
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -1
		combopoints_sword -= 1
		$Timer.start()
		$AnimationPlayer.play("sword_attack")
	elif  Input.is_action_just_pressed("attack_sword") && combopoints_sword == 2 && $AnimationPlayer.current_animation != "sword_attack" && $AnimationPlayer.current_animation != "axe_attack1" && $AnimationPlayer.current_animation != "axe_attack2" && $AnimationPlayer.current_animation != "axe_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 1
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -1
		combopoints_sword -= 1
		$Timer.start()
		$AnimationPlayer.play("sword_attack2")
	elif  Input.is_action_just_pressed("attack_sword") && combopoints_sword == 1 && $AnimationPlayer.current_animation != "sword_attack2" && $AnimationPlayer.current_animation != "axe_attack1" && $AnimationPlayer.current_animation != "axe_attack2" && $AnimationPlayer.current_animation != "axe_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 1
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -1
		combopoints_sword -= 1
		$Timer.start()
		$AnimationPlayer.play("sword_attack3")
	elif Input.is_action_just_pressed("attack_axe") && combopoints_axe == 3 && $AnimationPlayer.current_animation != "sword_attack" && $AnimationPlayer.current_animation != "sword_attack2" && $AnimationPlayer.current_animation != "sword_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 2
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -2
		combopoints_axe -= 1
		$Timer2.start()
		$AnimationPlayer.play("axe_attack1")
	elif Input.is_action_just_pressed("attack_axe") && combopoints_axe == 2 && $AnimationPlayer.current_animation != "axe_attack1" && $AnimationPlayer.current_animation != "sword_attack" && $AnimationPlayer.current_animation != "sword_attack2" && $AnimationPlayer.current_animation != "sword_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 2
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -2
		combopoints_axe -= 1
		$Timer2.start()
		$AnimationPlayer.play("axe_attack2")
	elif Input.is_action_just_pressed("attack_axe") && combopoints_axe == 1 && $AnimationPlayer.current_animation != "axe_attack2" && $AnimationPlayer.current_animation != "sword_attack" && $AnimationPlayer.current_animation != "sword_attack2" && $AnimationPlayer.current_animation != "sword_attack3":
		if Input.is_action_pressed("move_right") and $Sprite.flip_h == true:
			velosity.x = 2
		elif Input.is_action_pressed("move_left") and $Sprite.flip_h == false:
			velosity.x = -2
		combopoints_axe -= 1
		$Timer2.start()
		$AnimationPlayer.play("axe_attack3")
	elif $AnimationPlayer.current_animation != "sword_attack" && $AnimationPlayer.current_animation != "sword_attack2" && $AnimationPlayer.current_animation != "sword_attack3" && $AnimationPlayer.current_animation != "axe_attack1" && $AnimationPlayer.current_animation != "axe_attack2" && $AnimationPlayer.current_animation != "axe_attack3":
		
		anim_move()
		
		if Input.is_action_pressed("move_left"):
			velosity.x = -speed
			$Sprite.flip_h = false
		elif Input.is_action_pressed("move_right"):
			velosity.x = speed 
			$Sprite.flip_h = true
		else:
			velosity.x = 0
		
		if Input.is_action_just_pressed("jump") and velosity.y == 0:
			velosity.y = -jump
	
	velosity.y += gravity
	
	velosity = move_and_slide(velosity,FLOOR)
	
	
	
func anim_move():
	var anim_move = ""
	if $AnimationPlayer.current_animation != "death":
		anim_move = "idle"
		if velosity.y < 0:
			anim_move = "jump"
		elif velosity.y > 0:
			anim_move = "fall"
		elif velosity.x != 0:
			anim_move = "run"
		$AnimationPlayer.play(anim_move)
	
	
	
func hit():
	$AnimationPlayer.play("death")


func _on_SwordHit_body_entered(body):
	if $AnimationPlayer.current_animation == "axe_attack1" || $AnimationPlayer.current_animation == "axe_attack2" || $AnimationPlayer.current_animation == "axe_attack3" and body.is_in_group("enemy"):
		body.hitaxe()
	if $AnimationPlayer.current_animation == "sword_attack" || $AnimationPlayer.current_animation == "sword_attack2" || $AnimationPlayer.current_animation == "sword_attack3" and body.is_in_group("enemy"):
		body.hit()
	

func _on_Timer_timeout():
	combopoints_sword = 3


func _on_Timer2_timeout():
	combopoints_axe = 3
