extends Area2D

#onready
@onready var bubble :Sprite2D = $Sprite2D/Bubble


#stats
@export var max_health :float = 4.0
@export var tower_rotation :float = 0.3
@export var money :int = 50

var health :float


func _ready():
	health = max_health


func _process(_delta):
	update_health()
	update_bubble_stages()


func update_bubble_stages():
	if health >= max_health * 0.83:
		bubble.set_frame(4)
	elif health >= max_health * 0.67:
		bubble.set_frame(3)
	elif health >= max_health * 0.50:
		bubble.set_frame(2)
	elif health >= max_health * 0.33:
		bubble.set_frame(1)
	elif health >= max_health * 0.17:
		bubble.set_frame(0)


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
