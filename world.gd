extends Node2D


@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D

@onready var level_completed = $CanvasLayer/LevelCompleted

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	#This mkaes the "Polygon2d" color go with the shape of the collision shape we made
	polygon_2d.polygon = collision_polygon_2d.polygon
	#From the level completed signal we  auotload, after being emitted when all hearts are collected this will come to connect
	Events.level_completed.connect(show_level_completed)

func show_level_completed():
	#Once the hearts are collect, the emit signal in hearts will activatet he signal to connect and hsow the level complete here
	level_completed.show()	
	
	#This pauses the game when the final heart is collected
	get_tree().paused = true
	
