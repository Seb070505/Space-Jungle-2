extends KinematicBody2D

var speed = 125
var motion = Vector2.ZERO
var player = null

var health = 100
var player_inattack_zone = false
var can_take_damage = true

onready var animation = $AnimationPlayer

func _physics_process(delta):
	
	
	motion = Vector2.ZERO
	deal_with_damage_1()
	deal_with_damage_2()
	deal_with_damage_3()
	enemy_health()
	
	if player:
		if global.skeleton_enemy_alive == true:
			motion = position.direction_to(player.position) * speed
			if player_inattack_zone == false:
				animation.play("skeleton_walking")

	if player == null:
		animation.play("skeleton_idle")
	
	if player_inattack_zone == true and global.skeleton_enemy_alive == true:
		animation.play("skeleton_attack")
	
	if motion.x > 0:
		$SkeletonSprite.flip_h = false
	if motion.x < 0:
		$SkeletonSprite.flip_h = true
	
	motion.y += global.gravity * 20 * delta
	
	motion = move_and_slide(motion, Vector2.UP)


func _on_detection_area_body_entered(body):
	player = body


func _on_detection_area_body_exited(body):
	player = null

func enemy():
	pass
	

func _on_skeleton_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_skeleton_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false


func deal_with_damage_1():
	if player_inattack_zone == true and global.player_attack_1 == true:
		if can_take_damage == true:
			health = health - 25
			can_take_damage = false
			print("enemy has ", health, " health")
			if health <= 0:
				health = 0
				global.skeleton_enemy_alive = false
				animation.play("skeleton_death")
				$skeleton_death.start()
				$enemy_alive_timer.start()
			$take_damage_cooldown_1.start()

func deal_with_damage_2():
	if player_inattack_zone == true and global.player_attack_2 == true:
		if can_take_damage == true:
			health = health - 25
			can_take_damage = false
			print("enemy has ", health, " health")
			if health <= 0:
				health = 0
				global.skeleton_enemy_alive = false
				animation.play("skeleton_death")
				$skeleton_death.start()
				$enemy_alive_timer.start()
			$take_damage_cooldown_2.start()

func deal_with_damage_3():
	if player_inattack_zone == true and global.player_attack_3 == true:
		if can_take_damage == true:
			health = health - 75
			can_take_damage = false
			print("enemy has ", health, " health")
			if health <= 0:
				health = 0
				global.skeleton_enemy_alive = false
				animation.play("skeleton_death")
				$skeleton_death.start()
				$enemy_alive_timer.start()
			$take_damage_cooldown_3.start()


func _on_take_damage_cooldown_1_timeout():
	can_take_damage = true


func _on_take_damage_cooldown_2_timeout():
	can_take_damage = true


func _on_take_damage_cooldown_3_timeout():
	can_take_damage = true


func _on_skeleton_death_timeout():
	self.queue_free()

func enemy_health():
	var healthbar = $lifebar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_enemy_alive_timer_timeout():
	global.skeleton_enemy_alive = true
