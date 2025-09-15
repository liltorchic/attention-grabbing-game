extends "res://scripts/disctactions/distraction.gd"

var button:Button 
var label:Label
var timer_autoclicker:Timer

var autoclicker:bool = false

func _ready() -> void:
	button = get_node("Button")
	label = get_node("clicker")
	timer_autoclicker = get_node("Timer_Autoclick")
	
	init()
	
	if(self.UI_MODE):
		button.disabled = true
	else:
		#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.present_init_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func present_init_upgrade_data():
	self.upgrade_level_1_title = "Amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_price = 10
	self.upgrade_level_1_price_increase = 2

	self.upgrade_level_2_title = "Multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_price = 800
	self.upgrade_level_2_price_increase = 2.5
	
	self.upgrade_level_3_title = "Autoclicker"
	self.upgrade_level_3_desc = "what are you even doing here"
	self.upgrade_level_3_price = 2000
	self.upgrade_level_3_price_increase = 2
	self.upgrade_level_3_one_time = true
	self.upgrade_level_3_level = 0
	
	self.upgrade_level_4_title = "Autoclick Freq."
	self.upgrade_level_4_desc = "2x"
	self.upgrade_level_4_price = 2500
	self.upgrade_level_4_price_increase = 3

func init() -> void:
	self.title = "clicker"
	self.price = 0
	self.amount = 1
	self.mult = 1
	self.auto = false
	self.autofreq = 1
	

#Amount
func upgrade_1():
	if(self.upgrade_level_1_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_1_price)
		self.upgrade_level_1_price = upgrade_level_1_price * upgrade_level_1_price_increase
		self.upgrade_level_1_level = upgrade_level_1_level + 1
		
		#upgrade
		self.amount += 1
		
#Multiplier
func upgrade_2():
	if(self.upgrade_level_2_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_2_price)
		self.upgrade_level_2_price = upgrade_level_2_price * upgrade_level_2_price_increase
		self.upgrade_level_2_level = upgrade_level_2_level + 1
		
		#upgrade
		self.mult += 0.1

#autoclicker	
func upgrade_3():
	if(self.upgrade_level_3_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_3_price)
		self.upgrade_level_3_price = upgrade_level_3_price * upgrade_level_3_price_increase
		self.upgrade_level_3_level = upgrade_level_3_level + 1
		
		#upgrade
		self.auto = true
		self.timer_autoclicker.start(1)

#boost
func upgrade_4():
	if(self.upgrade_level_4_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_4_price)
		self.upgrade_level_4_price = upgrade_level_4_price * upgrade_level_4_price_increase
		self.upgrade_level_4_level = upgrade_level_4_level + 1
		#upgrade
		self.autofreq = self.autofreq / 2
		if(upgrade_level_4_level >= 4):
			self.upgrade_level_4_disabled = true
	

func _on_button_pressed() -> void:
	var reward = self.amount * Game.get_multiplier() * self.mult
	Game.add_time_points(reward)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)

func _on_gui_input(event: InputEvent) -> void:
	if not self.UI_MODE:
		if event is not InputEventMouseMotion:
			if event.pressed:
				Game.set_selected(self)


func _on_timer_autoclick_timeout() -> void:
	timer_autoclicker.start(self.autofreq)
	button.emit_signal("pressed")
