extends Node


var time_points = 0
var lives = 10

const panel_size = 128

func _ready() -> void:
	print("hi from singlton")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_time_point():
	time_points += 1
	
func add_time_points(_p:int):
	time_points += _p

func remove_life():
	if(lives - 1 > 0):
		lives -= 1
	else:
		print("you died")
		#dead
