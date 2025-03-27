extends ColorRect

var button:Button 
var label:Label

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")


func _on_button_pressed() -> void:
	var reward = 1 * Game.get_multiplier()
	Game.add_time_points(reward)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)

		
