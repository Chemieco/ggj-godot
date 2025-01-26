extends OptionButton

@onready var player = $".."
@onready var tower_normal = $"../TowerNormal"
@onready var tower_slow = $"../TowerSlow"


var money_back :float = 0.5
var child


func _process(delta):
	check_money()


func check_money():
	if player.money < tower_normal.tower_cost and player.money < tower_slow.tower_cost:
		modulate.a = 0.5
		disabled = true
	elif player.money >= tower_normal.tower_cost or player.money >= tower_slow.tower_cost:
		modulate.a = 1
		disabled = false


func _on_item_selected(index):
	if index == 0:
		if player.money >= tower_normal.tower_cost:
			spawn_tower_normal()
			set_item_disabled(0, true)
			set_item_disabled(1, true)
			set_item_disabled(2, false)
			player.money -= tower_normal.tower_cost
			self_modulate.a = 0
			#self.disabled = true
		elif player.money < tower_slow.tower_cost:
			selected = -1
			#TODO error sound
	elif index == 1:
		if player.money >= tower_slow.tower_cost:
			spawn_tower_slow()
			set_item_disabled(0, true)
			set_item_disabled(1, true)
			set_item_disabled(2, false)
			player.money -= tower_slow.tower_cost
			self_modulate.a = 0
			#self.disabled = true
		elif player.money < tower_slow.tower_cost:
			selected = -1
			#TODO error sound
	elif index == 2:
		player.money += child.tower_cost * money_back
		child.call("queue_free")
		set_item_disabled(0, false)
		set_item_disabled(1, false)
		set_item_disabled(2, true)
		self_modulate.a = 1
		selected = -1


func spawn_tower_normal():
	var new_tower_normal = preload("res://scenes/player/buildings/tower_normal.tscn").instantiate()
	new_tower_normal.global_position = global_position + Vector2(16, 16)
	child = new_tower_normal
	player.add_child(new_tower_normal)


func spawn_tower_slow():
	var new_tower_slow = preload("res://scenes/player/buildings/tower_slow.tscn").instantiate()
	new_tower_slow.global_position = global_position + Vector2(16, 16)
	child = new_tower_slow
	player.add_child(new_tower_slow)
