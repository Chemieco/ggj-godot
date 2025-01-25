extends Label

@onready var player = $"../.."
@onready var main = $"../../.."


func _process(_delta):
	text = str("money=", player.money) + " " + str("health=", player.health)
