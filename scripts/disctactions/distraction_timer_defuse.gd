extends "res://scripts/disctactions/distraction.gd"

var countdown_timer:Timer
var hidden_timer:Timer
var scorer:Timer
var label:Label
var button:Button

var rng = RandomNumberGenerator.new()

var timer_hidden:bool
var timer_amount:int = 3

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
		hidden_timer.start(rng.randf_range(6, 12))
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
	
	self.upgrade_level_4_title = "alarM"
	self.upgrade_level_4_desc = "get an alarm"
	self.upgrade_level_4_startingprice = 100000000
	self.upgrade_level_4_type = Constants.Type.ALARM
	

func init() -> void:
	self.title = "defuser"
	self.price = 2

func update_labels():
	pass
	
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
	hidden_timer.start(rng.randf_range(6, 12))
	button.visible = false
	particle_tree = p.instantiate()
	add_child(particle_tree)
	particle_tree.emit(reward,2.0)
	
