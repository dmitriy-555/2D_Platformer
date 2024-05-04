extends KinematicBody2D

var velocity = Vector2(0, 0)
var speed = 50
var is_moving_left = true
var player = null
var gravity = 9
var sword_hit_points = 2

func _ready():
	$AnimationPlayer.play("run")

func _process(_delta):
	print($RayCast2D3.is_colliding())
	move_character()
	detect_turn_around()
	



func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
	if $RayCast2D3.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("attack")
		player = body

func attack():
	if player != null:
		player.hit()

func _on_Area2D_body_exited(body):
	if $AnimationPlayer.current_animation == "death":
		return
	$AnimationPlayer.animation_set_next("attack", "Run")
	if body.is_in_group("player"):
		player = null

func hit():
	if $AnimationPlayer.current_animation != "death":
		$AnimationPlayer.play("mini_death")
	if sword_hit_points >= 0:
		sword_hit_points -= 1
	if sword_hit_points == 0: 
		$AnimationPlayer.play("death")
