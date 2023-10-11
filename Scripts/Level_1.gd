extends Node2D


func _on_death_body_entered(body):
	if body.has_method("player"):
		body.die()
