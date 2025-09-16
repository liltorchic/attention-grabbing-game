extends "res://scripts/disctactions/distraction.gd"

var countdown_timer:Timer
var hidden_timer:Timer
var scorer:Timer
var label:Label
var button:Button

var rng = RandomNumberGenerator.new()

var timer_hidden:bool

var timer_amount:int = 3
var timer_rng_lower:int = 6
var timer_rng_upper:int = 12
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown_timer = get_node("TimerCountdown")
	hidden_timer = get_node("TimerHidden")
	label = get_node("Label")
	button = get_node("Button")
	label.text = ""
	timer_hidden = true
	button.visible = false
	
	init()
	
	if(self.UI_MODE):
		button.disabled = true
	else:
		countdown_timer.set_wait_time(timer_amount + 0.01) # +0.01 so the scorewr can score on 0.00
		hidden_timer.start(rng.randf_range(timer_rng_lower, timer_rng_upper))
				#for upgrade
		var upgrade_node_target = get_node("../../../../../HBoxContainer/VBoxContainer_UI_Upgrade/ColorRect/VBoxContainer/upgrade/ScrollContainer/VBoxContainer")
		var u:upgrade_item = upgrade.instantiate()
		self.update_upgrade_data()
		upgrade_node_target.add_child(u)
		u.link(self)
		
func update_upgrade_data():
	self.upgrade_level_1_title = "amount"
	self.upgrade_level_1_desc = "+1"
	self.upgrade_level_1_price = 100
	self.upgrade_level_1_price_increase = 1.5
	
	self.upgrade_level_2_title = "multiplier"
	self.upgrade_level_2_desc = "+0.1x"
	self.upgrade_level_2_price = 1000
	self.upgrade_level_2_price_increase = 1.25
	
	self.upgrade_level_3_title = "peace"
	self.upgrade_level_3_desc = "rest easier"
	self.upgrade_level_3_price = 1000
	self.upgrade_level_3_price_increase = 1.1
	
	self.upgrade_level_4_title = "alarm"
	self.upgrade_level_4_desc = "get an alarm"
	self.upgrade_level_4_price = 100000
	self.upgrade_level_4_one_time = true
	
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

#peace	
func upgrade_3():
	if(self.upgrade_level_3_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_3_price * Game.discount)
		self.upgrade_level_3_price = upgrade_level_3_price * Game.discount * upgrade_level_3_price_increase
		self.upgrade_level_3_level = upgrade_level_3_level + 1
		
		#upgrade
		self.timer_amount += 1
		self.timer_rng_lower += 1
		self.timer_rng_upper += 2

#alarm
func upgrade_4():
	if(self.upgrade_level_4_price * Game.discount <= Game.get_points()):
		Game.remove_time_points(upgrade_level_4_price * Game.discount)
		self.upgrade_level_4_price = upgrade_level_4_price * Game.discount * upgrade_level_4_price_increase
		self.upgrade_level_4_level = upgrade_level_4_level + 1
		#upgrade
		self.alarm = true
	

func init() -> void:
	self.title = "defuser"
	self.price = 200

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!timer_hidden):
		label.text =  str("%.2f" % [countdown_timer.time_left])
	
#reset
func _on_timer_hidden_timeout() -> void:
	timer_hidden = false
	button.visible = true
	countdown_timer.start()
	
#you lose
func _on_timer_countdown_timeout() -> void:
	countdown_timer.stop()
	hidden_timer.stop()
	label.text = "0.00"
	Game.remove_life()
	print("suprise defuse timeout")

#defuse
func _on_button_pressed() -> void:
	var reward = 20 + self.amount * (Game.get_multiplier() + self.mult)
	if(!countdown_timer.is_stopped()):
		Game.add_time_points(reward)	
	timer_hidden = true
	label.text = ""
	countdown_timer.stop()
	countdown_timer.set_wait_time(timer_amount)
	hidden_timer.start(rng.randf_range(timer_rng_lower, timer_rng_upper))
	button.visible = false
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)
	
func _on_gui_input(event: InputEvent) -> void:
	if not self.UI_MODE:
		if event is not InputEventMouseMotion:
			if event.pressed:
				Game.set_selected(self)
