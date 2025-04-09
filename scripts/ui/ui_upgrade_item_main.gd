extends Node


@onready var title :Label = $ColorRect/VBoxContainer/Label_Title

#mult
@onready var upgrade_1_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Label_Price
@onready var upgrade_1_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Button
var upgrade_1_price_f:float = 1000.0
var upgrade_1_type:Constants.Type = Constants.Type.MULTIPLIER

#lives
@onready var upgrade_2_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Label_Price
@onready var upgrade_2_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Button
var upgrade_2_price_f:float = 10000.0
var upgrade_2_type:Constants.Type = Constants.Type.BASE_LIVES

#data
@onready var upgrade_3_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Label_Price
@onready var upgrade_3_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Button
var upgrade_3_price_f:float = 100.0
var upgrade_3_type:Constants.Type = Constants.Type.BASE_DATA

#discount
@onready var upgrade_4_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Label_Price
@onready var upgrade_4_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Button
var upgrade_4_price_f:float = 10000.0
var upgrade_4_type:Constants.Type = Constants.Type.BASE_DISCOUNT

func _ready() -> void:
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
	


func _on_button_pressed() -> void:
	if(upgrade_1_price_f <= Game.get_points()):
		upgrade_1_price_f = Game.recalc_price(upgrade_1_price_f)
		Game.remove_time_points(upgrade_1_price_f)
		do_upgrade(upgrade_1_type)
		if(upgrade_1_type == Constants.Type.BASE_DATA):
			upgrade_1_button.disabled = true
			upgrade_1_price_f = -1
		update_price_labels()


func _on_button_pressed_2() -> void:
	if(upgrade_2_price_f <= Game.get_points()):
		upgrade_2_price_f = Game.recalc_price(upgrade_2_price_f)
		Game.remove_time_points(upgrade_2_price_f)
		do_upgrade(upgrade_2_type)
		if(upgrade_2_type == Constants.Type.BASE_DATA):
			upgrade_2_button.disabled = true
			upgrade_2_price_f = -1
		update_price_labels()


func _on_button_pressed_3() -> void:
	if(upgrade_3_price_f <= Game.get_points()):
		upgrade_3_price_f = Game.recalc_price(upgrade_3_price_f)
		Game.remove_time_points(upgrade_3_price_f)
		do_upgrade(upgrade_3_type)
		if(upgrade_3_type == Constants.Type.BASE_DATA):
			upgrade_3_button.disabled = true
			upgrade_3_price_f = -1
		update_price_labels()


func _on_button_pressed_4() -> void:
	if(upgrade_4_price_f <= Game.get_points()):
		upgrade_4_price_f = Game.recalc_price(upgrade_4_price_f)
		Game.remove_time_points(upgrade_4_price_f)
		do_upgrade(upgrade_4_type)
		if(upgrade_4_type == Constants.Type.BASE_DATA):
			upgrade_4_button.disabled = true
			upgrade_4_price_f = -1
		update_price_labels()
		
func do_upgrade(_upgrade_type:Constants.Type):
	match _upgrade_type:
		Constants.Type.MULTIPLIER:
			Game.add_base_mult(0.1)
		Constants.Type.BASE_LIVES:
			pass
		Constants.Type.BASE_DATA:
			pass
		Constants.Type.BASE_DISCOUNT:
			pass
