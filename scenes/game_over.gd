extends CanvasLayer

signal stop_music

#onready
@onready var anim = $"../Hud/AnimationPlayer"
@onready var player = $"../Player"
@onready var points_label = $Stats/Points



func _ready():
	self.set_visible(false)


func _process(_delta):
	points_label.text = "%02d" % player.score


func fade():
	anim.play("fade")
	await anim.animation_finished
	stop_music.emit()
	%Outro.play()


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_back_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
