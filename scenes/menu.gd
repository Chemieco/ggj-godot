extends Control





func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")



func _on_credit_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_settings_pressed():
	PauseMenu.show_pause_menu()
