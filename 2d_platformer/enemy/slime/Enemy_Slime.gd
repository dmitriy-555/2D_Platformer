extends KinematicBody2D
var gravity = 9
var velocity = Vector2(0, 0)
var speed = 32
var is_moving_left = true
var player = null
var sword_hit_points = 2
var plr = 0

func _ready():
	$AnimationPlayer.play("Run")

func _physics_process(delta):
	if $AnimationPlayer.current_animation != "Death"  && $AnimationPlayer.current_animation != "mini_death" :
		if plr == player:
			$AnimationPlayer.play("Attack")
	if $AnimationPlayer.current_animation == "Attack":
		return
	if $AnimationPlayer.current_animation == "Death":
		return
	if $AnimationPlayer.current_animation == "mini_death":
		return
	if $AnimationPlayer.current_animation != "Attack" && $AnimationPlayer.current_animation != "Death"  && $AnimationPlayer.current_animation != "mini_death" :
		$AnimationPlayer.play("Run")
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
	if $RayCast2D2.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x

func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("Attack")
		player = body
		plr = player
func _on_PlayerDetector_body_exited(body):
	if $AnimationPlayer.current_animation == "Death":
		return
	$AnimationPlayer.animation_set_next("Attack", "Run")
	if body.is_in_group("player"):
		player = null
		plr = 0

func attack():
	if player != null:
		player.hit()

func hit():
	if $AnimationPlayer.current_animation != "Death":
		$AnimationPlayer.play("mini_death")
	if sword_hit_points > 0:
		sword_hit_points -= 1
	if sword_hit_points == 0: 
		$AnimationPlayer.play("Death")

func hitaxe():
		$AnimationPlayer.play("Death")
#func attackanim():
#	$AnimationPlayer.play("Attack")


func _on_PlayerDetector2_body_entered(body):
	if body.is_in_group("player"):
		is_moving_left = !is_moving_left
		scale.x = -scale.x



