extends Node2D

#onready
@onready var player = $Player
@onready var spawn_path_right :PathFollow2D = $PathRight/SpawnPathRight
@onready var spawn_path_left :PathFollow2D = $PathLeft/SpawnPathLeft

#stats
var enemy_lvl :int = 1

#misc
var spawn_path :Array
var spawn_time : float = 3.0
var spawn_time_counter :float = 0.0
var spawn_time_mod :float = 0.9
var next_enemy_type :Array = ["spawn_enemy_nautilus", "spawn_enemy_puffer", "spawn_enemy_sword"]
var buildingcount: int = 0


func _ready():
	randomize()
	
	spawn_path = [spawn_path_right, spawn_path_left]
	#final music off
	buildingcount = 0
	AudioServer.set_bus_mute(5, true)


func _physics_process(delta):
	spawn_counter(delta)


func spawn_counter(delta):
	spawn_time_counter += delta
	if spawn_time_counter >= spawn_time:
		var next_enemy = next_enemy_type.pick_random()
		call(next_enemy)
		spawn_time_counter = 0


func spawn_enemy_nautilus():
	var new_enemy = preload("res://scenes/enemies/enemy_nautilus.tscn").instantiate()
	var next_spawn_path = spawn_path.pick_random()
	next_spawn_path.progress_ratio = randf()
	new_enemy.global_position = next_spawn_path.global_position
	add_child(new_enemy)


func spawn_enemy_puffer():
	var new_enemy = preload("res://scenes/enemies/enemy_puffer.tscn").instantiate()
	var next_spawn_path = spawn_path.pick_random()
	next_spawn_path.progress_ratio = randf()
	new_enemy.global_position = next_spawn_path.global_position
	add_child(new_enemy)


func spawn_enemy_sword():
	var new_enemy = preload("res://scenes/enemies/enemy_sword.tscn").instantiate()
	var next_spawn_path = spawn_path.pick_random()
	next_spawn_path.progress_ratio = randf()
	new_enemy.global_position = next_spawn_path.global_position
	add_child(new_enemy)


#final music on
func _on_building_tower_normal_building_spawned():
	buildingcount += 1
	if buildingcount == 3:
		AudioServer.set_bus_mute(5, false)

func _on_building_tower_heal_building_spawned():
	buildingcount += 1
	if buildingcount == 3:
		AudioServer.set_bus_mute(5, false)

func _on_building_tower_slow_building_spawned():
	buildingcount += 1
	if buildingcount == 3:
		AudioServer.set_bus_mute(5, false)


func _on_enemy_level_up_timeout():
	enemy_lvl += 1
	spawn_time *= spawn_time_mod
	
