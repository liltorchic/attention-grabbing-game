extends "res://scripts/disctactions/distraction.gd"
var timer:Timer
var label:Label
var scorer:Timer
var button:Button
var timer_length:int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	label = get_node("Label")
	scorer = get_node("Timer_Scorer")
	button = get_node("Button")
	
	init()
	
	if(self.UI_MODE):
		button.disabled = true
	else:
		timer.start(timer_length)
		_on_timer_scorer_timeout()
				#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.update_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func update_upgrade_data():
	self.upgrade_level_1_title = "click amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_price = 100
	self.upgrade_level_1_price_increase = 3
	
	self.upgrade_level_2_title = "multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_price = 1000
	self.upgrade_level_2_price_increase = 1.25
	
	self.upgrade_level_3_title = "countdown"
	self.upgrade_level_3_desc = "1.5x"
	self.upgrade_level_3_price = 10000
	self.upgrade_level_3_price_increase = 1.25
	
	self.upgrade_level_4_title = "alarm"
	self.upgrade_level_4_desc = "get an alarm"
	self.upgrade_level_4_price = 100000
	self.upgrade_level_4_one_time = true

func init() -> void:
	self.title = "timer"
	self.price = 100
	self.amount = 1
	
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

#alarm	
func upgrade_3():
	if(self.upgrade_level_3_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_3_price)
		self.upgrade_level_3_price = upgrade_level_3_price * upgrade_level_3_price_increase
		self.upgrade_level_3_level = upgrade_level_3_level + 1
		
		#upgrade
		self.timer_length = self.timer_length * 1.5

#tick amount
func upgrade_4():
	if(self.upgrade_level_4_price <= Game.get_points()):
		Game.remove_time_points(upgrade_level_4_price)
		self.upgrade_level_4_price = upgrade_level_4_price * upgrade_level_4_price_increase
		self.upgrade_level_4_level = upgrade_level_4_level + 1
		#upgrade
		self.alarm = true

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str("%.2f" % [timer.time_left])

func _on_timer_timeout() -> void:
	timer.stop()
	scorer.stop()
	label.text = "0.00"
	Game.remove_life()
	print("simple timer timeout")

func _on_button_pressed() -> void:
	timer.start(timer_length)
	scorer.start(1)
	
func _on_timer_scorer_timeout() -> void:
	var reward = self.amount * (Game.get_multiplier() + self.mult)
	scorer.start(1)
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(reward ,1.0,.02)
	Game.add_time_points(reward)
	
func _on_gui_input(event: InputEvent) -> void:
	if not self.UI_MODE:
		if event is not InputEventMouseMotion:
			if event.pressed:
				Game.set_selected(self)
