extends CharacterBody2D

#onready
@onready var player = $"../Player"
@onready var sprite = $Sprite2D
@onready var slow_timer :Timer = $SlowTimer




#stats

@export var base_speed :float = 50
@export var speed :float = base_speed
@export var damage :float = 1.0
@export var health :float = 1.0
@export var loot :int = 5


#misc
var target :Vector2
var direction :Vector2
var slowed :bool = false
var enemy_sprite :Array = ["res://assets/Nautilus_color_outline.png", "res://assets/Pufferfish.png", "res://assets/Schwertfish.png"]


func _ready():
	randomize()
	var next_sprite :String = enemy_sprite.pick_random()
	sprite.texture=ResourceLoader.load(next_sprite)
	target = player.global_position


func _physics_process(delta):
	move(delta)
	print(slow_timer.time_left)


func get_damage(x):
	health -= x
	
	if health <= 0:
		player.money += loot
		queue_free()
		#TODO death animation 


func get_slowed(b_dmg, b_slow_time):
	speed = base_speed * b_dmg
	slow_timer.wait_time = b_slow_time
	slow_timer.start()
	


func move(delta):
	direction = target - global_position
	direction = direction.normalized()
	global_position += speed * direction * delta
	
	if player.global_position.x - global_position.x > 0:
		sprite.flip_h = false
	elif player.global_position.x - global_position.x <= 0:
		sprite.flip_h = true
	else:
		queue_free()
