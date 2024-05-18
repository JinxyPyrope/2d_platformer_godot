extends CenterContainer

#When we muse a "Access With Unique Name" feature for contorl nodes it will place a percentage sign and creeates a unique name for it to be acessed
#This is done because overtime as your control nodes sceenes change and update it will make it easier for you to access  them for later so you don't have to updatet he pathway to saccess them instead you just use the unique name give n for later use
@onready var start_game_button = %StartGameButton


func _ready():
	start_game_button.grab_focus()
	pass

func _on_start_game_button_pressed():
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Levels/level_one.tscn")
	LevelTransition.fade_from_black()

func _on_quit_button_pressed():
	get_tree().quit()

