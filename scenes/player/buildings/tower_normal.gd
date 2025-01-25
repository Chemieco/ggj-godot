extends StaticBody2D


#onready
@onready var range_area :CollisionShape2D = $RangeArea/RangeArea
@onready var attack_speed :Timer = $AttackSpeed
@onready var player = $".."
@onready var building_tower_normal = $"../BuildingTowerNormal"





#stats
@export var attack_range_base :int = 100
@export var bubble_damage_base : float = 0.5
@export var reload_speed_base :float = 1.0
@export var tower_cost_base :int = 10
@export var upgrade_mod :float = 0.25

@export var attack_range :int = attack_range_base
@export var bubble_damage : float = bubble_damage_base
@export var reload_speed :float = reload_speed_base
@export var tower_cost :int = tower_cost_base


#misc
var targets :Array = []
var reloaded :bool = true



func _process(_delta):
	upgrade_stats()
	attack()


func attack():
	if targets.size() > 0 and reloaded == true:
		spawn_bubble_normal()


func _on_range_area_body_entered(body):
	if body.is_in_group("enemies"):
		targets.append(body)


func _on_range_area_body_exited(body):
	if body.is_in_group("enemies"):
		targets.erase(body)


func spawn_bubble_normal():
	var new_projectile = preload("res://scenes/player/buildings/bubble_normal.tscn").instantiate()
	var next_target = targets.pick_random()
	new_projectile.target = next_target
	add_child(new_projectile)
	reloaded = false


func _on_attack_speed_timeout():
	reloaded = true



func upgrade_stats():
	attack_range = attack_range_base + (building_tower_normal.tower_lvl * upgrade_mod)
	range_area.shape.radius = attack_range
	
	bubble_damage = bubble_damage_base + (building_tower_normal.tower_lvl * upgrade_mod)
	
	reload_speed = reload_speed_base - (building_tower_normal.tower_lvl * upgrade_mod * upgrade_mod)
	attack_speed.wait_time = reload_speed
	
	#tower_cost = tower_cost_base + (building_tower_normal.tower_lvl * upgrade_mod)
