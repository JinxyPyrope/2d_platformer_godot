extends Node2D

#Set up a variable that is for the net level when the player has completed one level
@export var next_level: PackedScene


@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer


func _ready():
	#This mkaes the "Polygon2d" color go with the shape of the collision shape we made
	#From the level completed signal we  auotload, after being emitted when all hearts are collected this will come to connect
	Events.level_completed.connect(show_level_completed)
	#This is setup to pause while the cocutdown animation is active 
	get_tree().paused = true
	start_in.visible = true
	LevelTransition.fade_from_black()
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	start_in.visible = false
	
	

func show_level_completed():
	#Once the hearts are collect, the emit signal in hearts will activatet he signal to connect and hsow the level complete here
	level_completed.show()	
	#If there's no variable in next level then we don't movee to a next level
	if not next_level is PackedScene: return
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)

	#This pauses the game when the final heart is collected
	#get_tree().paused = true
	
