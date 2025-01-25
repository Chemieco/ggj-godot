extends Area2D


#stats
@export var health :float = 3.0
@export var max_health :float = 3.0
@export var tower_rotation :float = 0.3
@export var money :int = 20


func update_health():
	if health >= max_health:
		health = max_health
	
	if health <= 0:
		queue_free()
		#TODO Death Animation


func _on_body_entered(body):
	#Enemies Group collide with Player
	if body.is_in_group("enemies"):
		print("ouch!", body, body.damage)
		health -= body.damage
		body.queue_free()
		## TODO death animation
