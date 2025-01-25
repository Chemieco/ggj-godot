extends CanvasLayer

const DEFAULT_VOLUME: float = 10.0

func _ready():
	hide()
	#set default volume at start
	AudioServer.set_bus_volume_db(0,DEFAULT_VOLUME)
	AudioServer.set_bus_volume_db(1,DEFAULT_VOLUME)
	AudioServer.set_bus_volume_db(2,DEFAULT_VOLUME)
	AudioServer.set_bus_volume_db(3,DEFAULT_VOLUME)
	AudioServer.set_bus_volume_db(5,DEFAULT_VOLUME)
	%VolumeSlider.value = DEFAULT_VOLUME

#toggle pause
func _unhandled_key_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		if visible:
			hide_pause_menu()
		else:
			show_pause_menu()

#set volume
func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
	AudioServer.set_bus_volume_db(1,value)
	AudioServer.set_bus_volume_db(2,value)
	AudioServer.set_bus_volume_db(3,value)
	AudioServer.set_bus_volume_db(5,value)
	if not %BgMusic.playing:
		%BgMusic.play()

#pause the game
func show_pause_menu():
	show()
	get_tree().paused = true

func hide_pause_menu():
	%BgMusic.stop()
	hide()
	get_tree().paused = false

#exit menu with mouse
func _on_background_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		hide_pause_menu()
