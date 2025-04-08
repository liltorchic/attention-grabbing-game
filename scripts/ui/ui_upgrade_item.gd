extends Node

class_name upgrade_item

@onready var title :Label = $ColorRect/VBoxContainer/Label_Title

@onready var upgrade_1_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_upgrade
@onready var upgrade_1_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_description
@onready var upgrade_1_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Label_Price
@onready var upgrade_1_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Button
var upgrade_1_price_f:float = 1.0
var upgrade_1_type:Constants.Type


@onready var upgrade_2_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_upgrade
@onready var upgrade_2_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_description
@onready var upgrade_2_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Label_Price
@onready var upgrade_2_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Button
var upgrade_2_price_f:float = 1.0
var upgrade_2_type:Constants.Type

@onready var upgrade_3_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_upgrade
@onready var upgrade_3_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_description
@onready var upgrade_3_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Label_Price
@onready var upgrade_3_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Button
var upgrade_3_price_f:float = 1.0
var upgrade_3_type:Constants.Type

@onready var upgrade_4_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_upgrade
@onready var upgrade_4_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_description
@onready var upgrade_4_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Label_Price
@onready var upgrade_4_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Button
var upgrade_4_price_f:float = 1.0
var upgrade_4_type:Constants.Type

var linked_distraction:Distraction

func link(input):
	linked_distraction = input
	title.text = str(linked_distraction)
	
	upgrade_1_title.text = linked_distraction.upgrade_level_1_title
	upgrade_1_desc.text = linked_distraction.upgrade_level_1_desc
	upgrade_1_price_f = linked_distraction.upgrade_level_1_startingprice
	upgrade_1_type = linked_distraction.upgrade_level_1_type
	
	upgrade_2_title.text = linked_distraction.upgrade_level_2_title
	upgrade_2_desc.text = linked_distraction.upgrade_level_2_desc
	upgrade_2_price_f = linked_distraction.upgrade_level_2_startingprice
	upgrade_2_type = linked_distraction.upgrade_level_2_type
	
	upgrade_3_title.text = linked_distraction.upgrade_level_3_title
	upgrade_3_desc.text = linked_distraction.upgrade_level_3_desc
	upgrade_3_price_f = linked_distraction.upgrade_level_3_startingprice
	upgrade_3_type = linked_distraction.upgrade_level_3_type
	
	upgrade_4_title.text = linked_distraction.upgrade_level_4_title
	upgrade_4_desc.text = linked_distraction.upgrade_level_4_desc
	upgrade_4_price_f = linked_distraction.upgrade_level_4_startingprice
	upgrade_4_type = linked_distraction.upgrade_level_4_type
	
	update_price_labels()
	
func update_price_labels():
	if(upgrade_1_price_f != -1):
		upgrade_1_price.text = str("%.3f" % [upgrade_1_price_f])
	else:
		upgrade_1_price.text = ""
		
	if(upgrade_2_price_f != -1):
		upgrade_2_price.text = str("%.3f" % [upgrade_2_price_f])
	else:
		upgrade_2_price.text = ""
		
	if(upgrade_3_price_f != -1):	
		upgrade_3_price.text = str("%.3f" % [upgrade_3_price_f])
	else:
		upgrade_3_price.text = ""	
		
	if(upgrade_4_price_f != -1):			
		upgrade_4_price.text = str("%.3f" % [upgrade_4_price_f])
	else:
		upgrade_4_price.text = ""
	
	linked_distraction.update_labels()
	


func _on_button_pressed() -> void:
	if(upgrade_1_price_f <= Game.get_points()):
		upgrade_1_price_f = Game.recalc_price(upgrade_1_price_f)
		Game.remove_time_points(upgrade_1_price_f)
		do_upgrade(upgrade_1_type)
		if(upgrade_1_type == Constants.Type.AUTOCLICKER):
			upgrade_1_button.disabled = true
			upgrade_1_price_f = -1
		update_price_labels()


func _on_button_pressed_2() -> void:
	if(upgrade_2_price_f <= Game.get_points()):
		upgrade_2_price_f = Game.recalc_price(upgrade_2_price_f)
		Game.remove_time_points(upgrade_2_price_f)
		do_upgrade(upgrade_2_type)
		if(upgrade_2_type == Constants.Type.AUTOCLICKER):
			upgrade_2_button.disabled = true
			upgrade_2_price_f = -1
		update_price_labels()


func _on_button_pressed_3() -> void:
	if(upgrade_3_price_f <= Game.get_points()):
		upgrade_3_price_f = Game.recalc_price(upgrade_3_price_f)
		Game.remove_time_points(upgrade_3_price_f)
		do_upgrade(upgrade_3_type)
		if(upgrade_3_type == Constants.Type.AUTOCLICKER):
			upgrade_3_button.disabled = true
			upgrade_3_price_f = -1
		update_price_labels()


func _on_button_pressed_4() -> void:
	if(upgrade_4_price_f <= Game.get_points()):
		upgrade_4_price_f = Game.recalc_price(upgrade_4_price_f)
		Game.remove_time_points(upgrade_4_price_f)
		do_upgrade(upgrade_4_type)
		if(upgrade_4_type == Constants.Type.AUTOCLICKER):
			upgrade_4_button.disabled = true
			upgrade_4_price_f = -1
		update_price_labels()
		
func do_upgrade(_upgrade_type:Constants.Type):
	match _upgrade_type:
		Constants.Type.AMOUNT:
			linked_distraction.amount += 1
		Constants.Type.MULTIPLIER:
			linked_distraction.mult += 0.1
		Constants.Type.AUTOCLICKER:
			linked_distraction.autoclicker = true
		Constants.Type.BOOST:
			pass
		Constants.Type.ALARM:
			pass
		Constants.Type.LOVE:
			pass
		Constants.Type.TORTURE:
			pass
		Constants.Type.UNDEFINED:
			pass
