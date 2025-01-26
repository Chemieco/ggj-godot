extends StaticBody2D

signal building_spawned

#onready
@onready var upgrade_tower = $Sprite2D/UpgradeTower
@onready var label = $Sprite2D/UpgradeTower/Label
@onready var player = $".."
@onready var heal_timer = $HealTimer


#stats
@export var tower_lvl :int = 0
@export var upgrade_mod :float = 0.25

@export var upgrade_cost_base :int = 75
@export var tower_heal_base :float = 1.0
@export var tower_speed_base : float = 5.0

var tower_heal :float 
var tower_speed :float
var upgrade_cost :int

#misc
var max_level :bool = false


func _ready():
	tower_heal = tower_heal_base
	tower_speed = tower_speed_base
	upgrade_cost = upgrade_cost_base
	
	label.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	upgrade_stats()
	#mute tower music
	AudioServer.set_bus_mute(2, true)


func _process(_delta):
	check_money()


func _on_upgrade_tower_pressed():
	player.money -= upgrade_cost
	tower_lvl += 1
	upgrade_cost = tower_lvl * upgrade_cost_base
	label.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	#music on
	if AudioServer.is_bus_mute(2):
		await %ViolinLoop.finished
		AudioServer.set_bus_mute(2, false)
		building_spawned.emit()


func check_money():
	if player.money < upgrade_cost:
		upgrade_tower.disabled = true
		modulate.a = 0.5
	elif player.money >= upgrade_cost and max_level == false:
		upgrade_tower.disabled = false
		modulate.a = 1.0


func heal():
	upgrade_stats()
	player.health += tower_heal


func upgrade_stats():
	tower_heal = tower_heal_base + (tower_lvl * upgrade_mod)
	
	if tower_speed >= 0.15:
		tower_speed = tower_speed_base - (tower_lvl * upgrade_mod * upgrade_mod)
		heal_timer.wait_time = tower_speed
	elif tower_speed < 0.15:
		max_level = true
		upgrade_tower.disabled = true


func _on_heal_timer_timeout():
	if tower_lvl > 0:
		heal()


func _on_intro_finished():
	%ViolinLoop.play()


func _on_violin_loop_finished():
	%ViolinLoop.play()


func _on_game_over_stop_music():
	%ViolinLoop.stop()
