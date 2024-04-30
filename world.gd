extends Node2D


@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	#This mkaes the "Polygon2d" color go with the shape of the collision shape we made
	polygon_2d.polygon = collision_polygon_2d.polygon
