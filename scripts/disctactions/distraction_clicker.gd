extends "res://scripts/disctactions/distraction.gd"

var button:Button 
var label:Label

var autoclicker:bool = false

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")
	
	init()
	
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
	self.upgrade_level_1_startingprice = 100
	self.upgrade_level_1_type = Constants.Type.AMOUNT
	
	self.upgrade_level_2_title = "multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_startingprice = 1000
	self.upgrade_level_2_type = Constants.Type.MULTIPLIER
	
	self.upgrade_level_3_title = "autoclicker"
	self.upgrade_level_3_desc = "click for you"
	self.upgrade_level_3_startingprice = 10000
	self.upgrade_level_3_type = Constants.Type.AUTOCLICKER
	
	self.upgrade_level_4_title = "boost duration"
	self.upgrade_level_4_desc = "+1 sec."
	self.upgrade_level_4_startingprice = 100000
	self.upgrade_level_4_type = Constants.Type.BOOST

func init() -> void:
	self.title = "clicker"
	self.price = 0
	self.amount = 1
	self.mult = 1
	

func _on_button_pressed() -> void:
	var reward = self.amount * Game.get_multiplier() * self.mult
	Game.add_time_points(reward)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)

func update_labels():
	pass
		
