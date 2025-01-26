extends CanvasLayer

#onready
@onready var anim = $"../Hud/AnimationPlayer"


func _ready():
	self.set_visible(false)


func fade():
	anim.play("fade")
	await anim.animation_finished


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
