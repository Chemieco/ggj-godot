extends Area2D

@onready var tower_normal :StaticBody2D = $".."


#stats
@export var speed :int = 50


#misc
var target
var direction :Vector2


func _ready():
	global_position = tower_normal.global_position


func _physics_process(delta):
	if target == null:
		queue_free()
		#TODO death animation
	else:
		move(delta)


func move(delta):
	direction = target.global_position - global_position
	direction = direction.normalized()
	global_position += speed * direction * delta


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.call("get_damage", tower_normal.bubble_damage)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
