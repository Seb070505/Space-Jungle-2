extends Node2D

func _physics_process(delta):
	if Input.is_action_pressed("jump"):
		get_tree().change_scene("res://Scenes/Game.tscn")
