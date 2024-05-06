#Tghis class_name along with connecting this script to resourve allows us to make create a new reource with the class name associated with it
class_name PlayerMovementData
#Resource has its own functions and logic making it different from ones like Node2D
extends Resource

@export var SPEED = 100.0
@export var ACCELERATION = 600
@export var FRICTION = 1000
@export var JUMP_VELOCITY = -300.0
@export var gravity_scale = 1.0
@export var air_resistance = 200
