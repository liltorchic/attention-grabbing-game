extends Node


var time_points:float = 100000000000 if Constants.dev else 0
var cumlative_points = 0
var isMultUnlocked = true
var isUpgradesUnlocked = true

var base_mult:float = 0.0

var lives = Constants.starting_lives
var multiplier:float = Constants.base_multiplier * 1.0
const panel_size = Constants.ui_panel_standard_size

var selected 

signal updated_selected


# includes multiplier
func add_time_point():
	time_points += 1.0 * multiplier
	cumlative_points += 1.0 * multiplier
	
# does not include multiplier
func add_time_points(_p:float):
	time_points += _p
	cumlative_points += _p
	
func remove_time_points(_p:float):
	time_points -= _p

func get_points() -> float:
	return time_points

func remove_life():
	if(lives - 1 > 0):
		lives -= 1
	else:
		print("you died")
	
func get_multiplier():
	return multiplier + base_mult

func add_to_multiplier( _f: float):
	multiplier =+ _f
	
func recalc_price(_in:float) -> float:
	return (_in * 1.25) + (100 * Game.multiplier)

func add_base_mult(_in:float):
	base_mult += _in
	
func set_selected(_in):
	selected = _in
	updated_selected.emit()
