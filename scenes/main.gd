extends Node2D

#onready
@onready var player = $Player
@onready var spawn_path_right :PathFollow2D = $PathRight/SpawnPathRight
@onready var spawn_path_left :PathFollow2D = $PathLeft/SpawnPathLeft


#stats



#misc
var spawn_path :Array
var spawn_time : float = 3.0
var spawn_time_counter :float = 0.0
var next_enemy_type :Array = ["spawn_enemy_normal"]
var max_time_scale :float = 3.0



func _ready():
	randomize()
	spawn_path = [spawn_path_right, spawn_path_left]


func _physics_process(delta):
	spawn_counter(delta)


func spawn_counter(delta):
	spawn_time_counter += delta
	if spawn_time_counter >= spawn_time:
		var next_enemy = next_enemy_type.pick_random()
		call(next_enemy)
		#TODO Array für zusätzliche Enemytypes einfügen
		spawn_time_counter = 0


func spawn_enemy_normal():
	var new_enemy = preload("res://scenes/enemies/enemy.tscn").instantiate()
	var next_spawn_path = spawn_path.pick_random()
	next_spawn_path.progress_ratio = randf()
	new_enemy.global_position = next_spawn_path.global_position
	add_child(new_enemy)


func _on_game_speed_timeout():
	if Engine.time_scale < max_time_scale:
		Engine.time_scale *= 1.1
	else:
		Engine.time_scale = max_time_scale
