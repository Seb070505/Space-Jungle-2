extends Area2D

export var value = 1

func _process(delta):
	rotation_degrees += 90 * delta


func _on_Noegle_body_entered(body):
	if body.has_method("player"):
		body.collect_key(value)
		queue_free()
