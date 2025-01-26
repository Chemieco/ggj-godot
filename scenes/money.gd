extends Label

#onready
@onready var player = $"../../Player"

func _process(_delta):
	text = str(player.money)
