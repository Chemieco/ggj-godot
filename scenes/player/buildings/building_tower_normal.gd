extends StaticBody2D

#onready
@onready var upgrade_tower = $Sprite2D/UpgradeTower
@onready var player = $".."


#stats
@export var upgrade_cost :int = 50
@export var tower_lvl :int = 1


#misc



func _ready():
	upgrade_tower.text = str(tower_lvl)


func _process(_delta):
	check_money()


func _on_upgrade_tower_pressed():
	player.money -= upgrade_cost
	tower_lvl += 1
	upgrade_tower.text = str(tower_lvl)
	upgrade_cost = tower_lvl * upgrade_cost


func check_money():
	if player.money < upgrade_cost:
		upgrade_tower.disabled = true
		modulate.a = 0.1
	elif player.money >= upgrade_cost:
		upgrade_tower.disabled = false
		modulate.a = 1
