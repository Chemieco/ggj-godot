extends StaticBody2D

signal building_spawned

#onready
@onready var upgrade_tower = $Sprite2D/UpgradeTower
@onready var player = $".."
@onready var label = $Sprite2D/UpgradeTower/Label



#stats
@export var tower_lvl :int = 0

@export var upgrade_cost_base :int = 50

var upgrade_cost :int

#misc



func _ready():
	upgrade_cost = upgrade_cost_base
	
	label.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	#mute tower music
	AudioServer.set_bus_mute(1, true)


func _process(_delta):
	check_money()


func _on_upgrade_tower_pressed():
	player.money -= upgrade_cost
	tower_lvl += 1
	upgrade_cost = tower_lvl * upgrade_cost_base
	label.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	#music on
	if AudioServer.is_bus_mute(1):
		await %BeatsLoop.finished
		AudioServer.set_bus_mute(1, false)
		building_spawned.emit()


func check_money():
	if player.money < upgrade_cost:
		upgrade_tower.disabled = true
		modulate.a = 0.5
	elif player.money >= upgrade_cost:
		upgrade_tower.disabled = false
		modulate.a = 1


func _on_intro_finished():
	%BeatsLoop.play()


func _on_beats_loop_finished():
	%BeatsLoop.play()


func _on_game_over_stop_music():
	%BeatsLoop.stop()
