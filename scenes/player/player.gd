extends Area2D

#onready
@onready var bubble :Sprite2D = $Sprite2D/Bubble


#stats
@export var health :float = 3.0
@export var max_health :float = 3.0
@export var tower_rotation :float = 0.3
@export var money :int = 20


func _process(_delta):
	update_health()


func update_health():
	if health >= max_health:
		health = max_health
	
	if health <= 0:
		get_tree().paused = true
		queue_free()
		#TODO Death Animation


func _on_body_entered(body):
	#Enemies Group collide with Player
	if body.is_in_group("enemies"):
		bubble.add_trauma(0.3)
		health -= body.damage
		body.queue_free()
		## TODO death animation
