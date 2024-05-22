extends Node2D

#Set up a variable that is for the net level when the player has completed one level
@export var next_level: PackedScene

var level_time = 0.0

#set up the timer varibale 
var start_level_msec = 0.0

@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var animation_player = $AnimationPlayer
@onready var level_time_label = %LevelTimeLabel


func _ready():
	if not next_level is PackedScene:
		level_completed.next_level_button.text = "Victory Screen"
		next_level = load("res://Ui/victory_screen.tscn")
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
	#"get_ticks_msec" keeps track of the amount of time passing as the game started
	start_level_msec = Time.get_ticks_msec()
	
func _process(_delta):
	#Shows and kees up with timer 
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text = str(level_time / 1000.0)

func retry():
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)

func go_to_next_level():
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	

func show_level_completed():
	#Once the hearts are collect, the emit signal in hearts will activatet he signal to connect and hsow the level complete here
	level_completed.show()	
	#If there's no variable in next level then we don't movee to a next level
	if not next_level is PackedScene: return
	level_completed.retry_button.grab_focus()
	get_tree().paused = true
	
	

	#This pauses the game when the final heart is collected
	#get_tree().paused = true
	


func _on_level_completed_retry():
	retry()


func _on_level_completed_next_level():
	go_to_next_level()
