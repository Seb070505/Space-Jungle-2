extends KinematicBody2D

onready var animation = $AnimationPlayer
var speed = 200
var jumpForce = 500
onready var sprite = $PlayerSprite
var velocity = Vector2.ZERO
var grounded = false
var walking_with_sword = false

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var health = 100
var attack_ip = false

func _ready():
	global.keys = 0

func _physics_process(delta):
	velocity.x = 0
	var attack_animation = false
	var jumping = false
	enemy_attack()
	update_health()
	
	if health <= 0:
		player_alive = false
		health = 0
		get_tree().change_scene("res://Scenes/Gameover.tscn")
	
	if Input.is_action_pressed("attack_1_j") and is_on_floor():
		animation.play("player_attack_1")
		attack_animation = true
		walking_with_sword = true
		attack_ip = true
		global.player_attack_1 = true
		$attack_1.start()
		$walking_with_sword.start()
		
	elif Input.is_action_pressed("attack_2_k") and is_on_floor():
		animation.play("player_attack_2")
		attack_animation = true
		walking_with_sword = true
		attack_ip = true
		global.player_attack_2 = true
		$attack_2.start()
		$walking_with_sword.start()
		
	elif Input.is_action_pressed("attack_3_l") and is_on_floor():
		animation.play("player_attack_3")
		attack_animation = true
		walking_with_sword = true
		attack_ip = true
		global.player_attack_3 = true
		$attack_3.start()
		$walking_with_sword.start()
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if is_on_floor() and walking_with_sword == false and attack_animation == false:
			animation.play("player_walking")
		if is_on_floor() and walking_with_sword == true and attack_animation == false:
			animation.play("player_walking_sword_out")
		sprite.flip_h = true
		
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
		if is_on_floor() and walking_with_sword == false and attack_animation == false:
			animation.play("player_walking")
		if is_on_floor() and walking_with_sword == true and attack_animation == false:
			animation.play("player_walking_sword_out")
		sprite.flip_h = false
	
	
	velocity.y += global.gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce 
		jumping = true
		animation.play("player_jumping")
	
	if velocity.x == 0 and is_on_floor() and attack_animation == false and jumping == false:
		if walking_with_sword == false:
			animation.play("player_idle")
		elif walking_with_sword == true:
			animation.play("idle_with_sword")
		
		
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout():
	walking_with_sword = false

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range == true and enemy_attack_cooldown == true and global.enemy_alive == true:
		health = health - 10
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print("player has ", health," health")
		
	if enemy_inattack_range == true and enemy_attack_cooldown == true and global.mushroom_enemy_alive == true:
		health = health - 10
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print("player has ", health," health")
		
	if enemy_inattack_range == true and enemy_attack_cooldown == true and global.skeleton_enemy_alive == true:
		health = health - 10
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print("player has ", health," health")


func _on_enemy_attack_cooldown_timeout():
	enemy_attack_cooldown = true



func _on_attack_1_timeout():
	$attack_1.stop()
	attack_ip = false
	global.player_attack_1 = false


func _on_attack_2_timeout():
	$attack_2.stop()
	attack_ip = false
	global.player_attack_2 = false

func _on_attack_3_timeout():
	$attack_3.stop()
	attack_ip = false
	global.player_attack_3 = false

func die():
	health = 0

func update_health():
	var healthbar = $lifebar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	

func _on_regin_timer_timeout():
	if health < 100 and enemy_inattack_range == false:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0

func collect_key(value):
	global.keys += value
