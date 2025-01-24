extends StaticBody2D


#onready
@onready var range_area :CollisionShape2D = $RangeArea/RangeArea
@onready var attack_speed :Timer = $AttackSpeed


#stats
@export var range :int = 100
@export var bubble_damage : float = 0.5
@export var reload_speed :float = 1.0


#misc
var targets :Array = []
var reloaded :bool = true


func _ready():
	range_area.shape.radius = range
	attack_speed.wait_time = reload_speed


func _process(delta):
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
