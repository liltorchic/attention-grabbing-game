extends "res://scripts/disctactions/distraction.gd"
var timer:Timer
var label:Label
var scorer:Timer
var button:Button
var timer_length:int = 60

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
	
	self.upgrade_level_4_title = "alart"
	self.upgrade_level_4_desc = "get an alarm"
	self.upgrade_level_4_startingprice = 100000000
	self.upgrade_level_4_type = Constants.Type.ALARM
	

func init() -> void:
	self.title = "timer"
	self.price = 100
	self.amount = 1
	
func update_labels():
	pass
	
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
	
	
