extends CharacterBody2D

#onready
@onready var player = $"../Player"
@onready var sprite = $Sprite2D
@onready var slow_timer :Timer = $SlowTimer
@onready var main = $".."

#stats
@export var lvl :int
@export var lvl_mod : float = 0.25

@export var base_speed :float = 60
@export var base_damage :float = 1
@export var base_health :float = 1.5
@export var base_loot :int = 10

var damage :float
var speed :float
var health :float
var loot :int

#misc
var target :Vector2
var direction :Vector2
var slowed :bool = false


func _ready():
	randomize()
	lvl = main.enemy_lvl
	damage = base_damage
	speed = base_speed
	health = base_health
	loot = base_loot
	
	if lvl > 1:
		stat_update()
	
	target = player.global_position


func _physics_process(delta):
	move(delta)


func get_damage(x):
	health -= x
	
	if health <= 0:
		player.money += loot
		player.score += base_health
		queue_free()
		#TODO death animation 


func get_slowed(b_dmg, b_slow_time):
	#if b_slow_time <= 0.125:
	#	b_slow_time = 0.125
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


func _on_slow_timer_timeout():
	speed = base_speed


func stat_update():
	damage = base_damage + (lvl * lvl_mod)
	speed = base_speed + (lvl * lvl_mod)
	health = base_health + (lvl * lvl_mod)
	loot = base_loot + (lvl * lvl_mod)
