extends StaticBody2D


#onready
@onready var range_area :CollisionShape2D = $RangeArea/RangeArea
@onready var attack_speed :Timer = $AttackSpeed
@onready var button = $Sprite2D/Button



#stats
@export var attack_range :int = 100
@export var bubble_damage : float = 0.5
@export var reload_speed :float = 1.0
@export var move_speed :int = 10


#misc
var targets :Array = []
var reloaded :bool = true
var active :bool = false


func _ready():
	modulate.a = 0.1
	
	range_area.shape.radius = attack_range
	attack_speed.wait_time = reload_speed


func _process(_delta):
	if active == true: 
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
	new_projectile.target = next_target.global_position
	add_child(new_projectile)
	reloaded = false


func _on_attack_speed_timeout():
	reloaded = true



func _on_button_toggled(_toggled_on):
	#TODO if cost < money:
	if button.button_pressed == true:
		modulate.a = 1.0
		active = true
	elif button.button_pressed == false:
		modulate.a = 0.1
		active = false
