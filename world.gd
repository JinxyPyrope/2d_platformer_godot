extends Node2D

#Set up a variable that is for the net level when the player has completed one level
@export var next_level: PackedScene


@onready var level_completed = $CanvasLayer/LevelCompleted

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	#This mkaes the "Polygon2d" color go with the shape of the collision shape we made
	#From the level completed signal we  auotload, after being emitted when all hearts are collected this will come to connect
	Events.level_completed.connect(show_level_completed)

func show_level_completed():
	#Once the hearts are collect, the emit signal in hearts will activatet he signal to connect and hsow the level complete here
	level_completed.show()	
	#If there's no variable in next level then we don't movee to a next level
	if not next_level is PackedScene: return
	get_tree().paused = true
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
	#This pauses the game when the final heart is collected
	#get_tree().paused = true
	
