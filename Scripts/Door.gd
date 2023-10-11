extends Area2D

onready var animation = $AnimationPlayer
var door_open = false

func _ready():
	if door_open == false:
		animation.play("RESET")

func _on_Area2D_body_entered(body):
	if body.has_method("player") and global.keys == 1:
		door_open = true
		animation.play("open_door")


func _on_Door_body_entered(body):
	if body.has_method("player") and global.keys >= 1:
		get_tree().change_scene("res://Scenes/Level 2.tscn")
