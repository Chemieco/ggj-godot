extends Area2D


#stats
@export var health :int = 3
@export var tower_rotation :float = 0.3



func _on_body_entered(body):
	#Enemies Group collide with Player
	if body.is_in_group("enemies"):
		print("ouch!", body, body.damage)
		body.queue_free()
		## TODO death animation
