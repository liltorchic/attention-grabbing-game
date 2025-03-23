extends ColorRect

var button:Button 
var label:Label

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")


func _on_button_pressed() -> void:
	Game.add_time_point()
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(1,2.0)

		
