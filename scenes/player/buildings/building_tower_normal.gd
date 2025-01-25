extends StaticBody2D

signal building_spawned

#onready
@onready var upgrade_tower = $Sprite2D/UpgradeTower
@onready var player = $".."


#stats
@export var upgrade_cost :int = 50
@export var tower_lvl :int = 1


#misc



func _ready():
	upgrade_tower.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	#mute tower music
	AudioServer.set_bus_mute(1, true)


func _process(_delta):
	check_money()


func _on_upgrade_tower_pressed():
	player.money -= upgrade_cost
	tower_lvl += 1
	upgrade_cost = tower_lvl * upgrade_cost
	upgrade_tower.text = str(tower_lvl) + "(" + str(upgrade_cost) + ")"
	#music on
	if AudioServer.is_bus_mute(1):
		AudioServer.set_bus_mute(1, false)
		building_spawned.emit()


func check_money():
	if player.money < upgrade_cost:
		upgrade_tower.disabled = true
		modulate.a = 0.1
	elif player.money >= upgrade_cost:
		upgrade_tower.disabled = false
		modulate.a = 1
