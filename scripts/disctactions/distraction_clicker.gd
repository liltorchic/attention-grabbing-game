extends "res://scripts/disctactions/distraction.gd"

var button:Button 
var label:Label

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree


@onready var upgrade = preload("res://scenes/upgrade_item.tscn")

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")
	
	if(self.UI_MODE):
		button.disabled = true
	else:
		#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.update_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func update_upgrade_data():
	self.upgrade_level_1_title = "click amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_startingprice = 1
	
	self.upgrade_level_2_title = ""
	self.upgrade_level_2_desc = ""
	self.upgrade_level_2_startingprice = 1
	
	self.upgrade_level_2_title = ""
	self.upgrade_level_2_desc = ""
	self.upgrade_level_2_startingprice = 1

func init() -> void:
	self.title = "clicker"
	self.price = 0

func _on_button_pressed() -> void:
	var reward = 1 * Game.get_multiplier()
	Game.add_time_points(reward)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)

		
