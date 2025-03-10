extends Node


var time_points = 0
var lifes = 10

func _ready() -> void:
	print("hi from singlton")


func add_time_point():
	time_points += 1
	
func add_time_points(_p:int):
	time_points += _p
