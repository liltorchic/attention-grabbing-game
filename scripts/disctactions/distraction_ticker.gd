extends "res://scripts/disctactions/distraction.gd"

var ticker:float
var timer:Timer
var scorer:Timer
var label:Label
var checklabel:Label
var checkbutton:CheckButton
var button:Button

var isChecked
var modifier = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	scorer = get_node("Timer_Scorer")
	label = get_node("Label")
	button = get_node("Button")
	checkbutton = get_node("CheckButton")
	checklabel = get_node("CheckButton/Label")
	
	init()
	
	if(self.UI_MODE):
		button.disabled = true
		checkbutton.disabled = true
	else:
		timer.start()
		_on_timer_scorer_timeout()
		_on_check_button_pressed()
				#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.update_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func update_upgrade_data():
	self.upgrade_level_1_title = "Amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_price = 1500
	self.upgrade_level_1_price_increase = 1.25

	self.upgrade_level_2_title = "multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_price = 2000
	self.upgrade_level_1_price_increase = 2
	
	self.upgrade_level_3_title = "alarm"
	self.upgrade_level_3_desc = "get an alarm"
	self.upgrade_level_3_price = 100000
	self.upgrade_level_3_one_time = true
	
	self.upgrade_level_4_title = "offset"
	self.upgrade_level_4_desc = "+ x1"
	self.upgrade_level_4_price = 15000
	self.upgrade_level_4_price_increase = 1.5
	

func init() -> void:
	ticker = 10
	self.title = "ticker"
	self.price = 5000
	self.amount = 1
	self.alarm = false
	
#Amount
func upgrade_1():
	if(self.upgrade_level_1_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_1_price * Game.discount)
		self.upgrade_level_1_price = upgrade_level_1_price * Game.discount * upgrade_level_1_price_increase
		self.upgrade_level_1_level = upgrade_level_1_level + 1
		
		#upgrade
		self.amount += 1
		
#Multiplier
func upgrade_2():
	if(self.upgrade_level_2_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_2_price * Game.discount)
		self.upgrade_level_2_price = upgrade_level_2_price * Game.discount * upgrade_level_2_price_increase
		self.upgrade_level_2_level = upgrade_level_2_level + 1
		
		#upgrade
		self.mult += 0.1

#alarm	
func upgrade_3():
	if(self.upgrade_level_3_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_3_price * Game.discount)
		self.upgrade_level_3_price = upgrade_level_3_price * Game.discount * upgrade_level_3_price_increase
		self.upgrade_level_3_level = upgrade_level_3_level + 1
		
		#upgrade
		self.alarm = true

#tick amount
func upgrade_4():
	if(self.upgrade_level_4_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_4_price * Game.discount)
		self.upgrade_level_4_price = upgrade_level_4_price * Game.discount * upgrade_level_4_price_increase
		self.upgrade_level_4_level = upgrade_level_4_level + 1
		#upgrade
		self.modifier += 1
		checklabel.text = "x" + str(self.modifier)


	
	
func update_labels():	
	var a = self.modifier * self.amount * (Game.get_multiplier() + self.mult)
	var b = 1 * self.amount * (Game.get_multiplier() + self.mult)
	isChecked = checkbutton.button_pressed
	
	var increment_score = a if isChecked else b
	button.text = "+" + str(increment_score)
	
func _on_timer_timeout() -> void:
	var a = self.modifier * self.amount * (Game.get_multiplier() + self.mult)
	var b = 1 * self.amount * (Game.get_multiplier() + self.mult)
	var increment_score = a if isChecked else b
	timer.start(1)
	ticker = ticker - increment_score
	label.text = str(ticker)
	update_labels()	
	if(ticker <= 0):
		timer.stop()
		scorer.stop()
		_timeout()
		init()
		timer.start()
		_on_timer_scorer_timeout()
		_on_check_button_pressed()

func _on_check_button_pressed() -> void:
	update_labels()

func _on_button_pressed() -> void:
	var a = self.modifier * self.amount * (Game.get_multiplier() + self.mult)
	var b = 1 * self.amount * (Game.get_multiplier() + self.mult)
	var increment_score = a if isChecked else b
	
	ticker = ticker + increment_score
	Game.add_time_points(increment_score)	
	label.text = str(ticker)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(increment_score,2.0)
	
func _on_timer_scorer_timeout() -> void:
	var a = self.modifier * self.amount * (Game.get_multiplier() + self.mult)
	var b = 1 * self.amount * (Game.get_multiplier() + self.mult)
	var increment_score = a if isChecked else b
	Game.add_time_points(increment_score)
	
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit_speed(increment_score,2.0,.02)
	
	scorer.start(1)
	
func _timeout():
	Game.remove_life()
	print("ticker timeout")
	
func _on_gui_input(event: InputEvent) -> void:
	if not self.UI_MODE:
		if event is not InputEventMouseMotion:
			if event.pressed:
				Game.set_selected(self)
