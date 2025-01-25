extends StaticBody2D


#onready
@onready var range_area :CollisionShape2D = $RangeArea/RangeArea
@onready var attack_speed :Timer = $AttackSpeed
@onready var button = $Sprite2D/Button
@onready var player = $".."
@onready var building_tower_slow = $"../BuildingTowerSlow"






#stats
@export var attack_range_base :int = 100
@export var bubble_damage_base : float = 0.5
@export var bubble_slow_time_base :float = 1.0
@export var reload_speed_base :float = 1.0
@export var tower_cost_base :int = 10
@export var upgrade_mod :float = 0.25

@export var attack_range :int = attack_range_base
@export var bubble_damage : float = bubble_damage_base
@export var bubble_slow_time :float = bubble_slow_time_base
@export var reload_speed :float = reload_speed_base
@export var tower_cost :int = tower_cost_base


#misc
var targets :Array = []
var reloaded :bool = true
var active :bool = false
var max_level :bool = false


func _ready():
	modulate.a = 0.1


func _process(_delta):
	upgrade_stats()
	check_money()
	attack()


func attack():
	if active == true: 
		if targets.size() > 0 and reloaded == true:
			spawn_bubble_slow()


func _on_range_area_body_entered(body):
	if body.is_in_group("enemies"):
		targets.append(body)


func _on_range_area_body_exited(body):
	if body.is_in_group("enemies"):
		targets.erase(body)


func spawn_bubble_slow():
	var new_projectile = preload("res://scenes/player/buildings/bubble_slow.tscn").instantiate()
	var next_target = targets.pick_random()
	new_projectile.target = next_target
	add_child(new_projectile)
	reloaded = false


func _on_attack_speed_timeout():
	reloaded = true


func check_money():
	if button.button_pressed == false and player.money < tower_cost:
		button.disabled = true
	elif button.button_pressed == false and player.money >= tower_cost and max_level == false:
		button.disabled = false


func _on_button_toggled(_toggled_on):
	#TODO if cost < money:
	if button.button_pressed == true:
		modulate.a = 1.0
		active = true
		player.money -= tower_cost
	elif button.button_pressed == false:
		modulate.a = 0.1
		active = false
		player.money += tower_cost


func upgrade_stats():
	attack_range = attack_range_base + (building_tower_slow.tower_lvl * upgrade_mod)
	range_area.shape.radius = attack_range
	
	if bubble_damage >= 0.1:
		bubble_damage = bubble_damage_base - (building_tower_slow.tower_lvl * upgrade_mod * upgrade_mod)
		bubble_slow_time = bubble_slow_time_base - (building_tower_slow.tower_lvl * upgrade_mod)
		print(bubble_damage)
	elif bubble_slow_time < 0.1:
		max_level = true
		building_tower_slow.upgrade_tower.disabled = true
	
	reload_speed = reload_speed_base - (building_tower_slow.tower_lvl * upgrade_mod * upgrade_mod)
	attack_speed.wait_time = reload_speed
	
	tower_cost = tower_cost_base + (building_tower_slow.tower_lvl * upgrade_mod)
