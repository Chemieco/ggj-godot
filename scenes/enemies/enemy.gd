extends CharacterBody2D

#onready
@onready var player = $"../Player"


#stats
@export var speed :float = 50
@export var damage :float = 1.0
@export var health :float = 1.0
@export var loot :int = 5


#misc
var target :Vector2
var direction :Vector2


func _ready():
	target = player.global_position


func _physics_process(delta):
	move(delta)


func get_damage(x):
	health -= x
	
	if health <= 0:
		player.money += loot
		queue_free()
		#TODO death animation 


func move(delta):
	direction = target - global_position
	direction = direction.normalized()
	global_position += speed * direction * delta
