extends Node2D

onready var animation = $AnimationPlayer

func _ready():
	animation.play("Gameover")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
