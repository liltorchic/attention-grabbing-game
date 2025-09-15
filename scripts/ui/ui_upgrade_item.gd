extends Node

class_name upgrade_item

@onready var title :Label = $ColorRect/VBoxContainer/Label_Title

@onready var highlight :ColorRect = $ColorRect

@onready var upgrade_1_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_upgrade
@onready var upgrade_1_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_description
@onready var upgrade_1_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Label_Price
@onready var upgrade_1_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Button


@onready var upgrade_2_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_upgrade
@onready var upgrade_2_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_description
@onready var upgrade_2_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Label_Price
@onready var upgrade_2_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Button

@onready var upgrade_3_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_upgrade
@onready var upgrade_3_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_description
@onready var upgrade_3_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Label_Price
@onready var upgrade_3_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Button

@onready var upgrade_4_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_upgrade
@onready var upgrade_4_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_description
@onready var upgrade_4_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Label_Price
@onready var upgrade_4_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Button

var linked_distraction:Distraction

var is_selected:bool = false

func link(input):
	self.linked_distraction = input
	self.title.text = str(linked_distraction.title)
	self.focus_mode = Control.FOCUS_NONE
	Game.updated_selected.connect(_selection_update)
	update_price_labels()
	
func update_price_labels():
	
	upgrade_1_title.text = linked_distraction.upgrade_level_1_title
	upgrade_1_desc.text = linked_distraction.upgrade_level_1_desc
	if(upgrade_1_price.text != "out of stock"):
		upgrade_1_price.text = str("%.2f" % [linked_distraction.upgrade_level_1_price])
	
	upgrade_2_title.text = linked_distraction.upgrade_level_2_title
	upgrade_2_desc.text = linked_distraction.upgrade_level_2_desc
	if(upgrade_2_price.text != "out of stock"):
		upgrade_2_price.text = str("%.2f" % [linked_distraction.upgrade_level_2_price])
	
	upgrade_3_title.text = linked_distraction.upgrade_level_3_title
	upgrade_3_desc.text = linked_distraction.upgrade_level_3_desc
	if(upgrade_3_price.text != "out of stock"):
		upgrade_3_price.text = str("%.2f" % [linked_distraction.upgrade_level_3_price])
	
	upgrade_4_title.text = linked_distraction.upgrade_level_4_title
	upgrade_4_desc.text = linked_distraction.upgrade_level_4_desc
	if(upgrade_4_price.text != "out of stock"):
		upgrade_4_price.text = str("%.2f" % [linked_distraction.upgrade_level_4_price])
	
func _selection_update():
	if Game.selected == linked_distraction:
		is_selected = true
		highlight.color = Color(0.466, 0.466, 0.466)
	else:
		is_selected = false
		highlight.color = Color(0.588, 0.588, 0.588)
		

func _on_button_pressed() -> void:
	self.linked_distraction.upgrade_1()
	if(linked_distraction.upgrade_level_1_one_time == true or linked_distraction.upgrade_level_1_disabled):
		upgrade_1_button.disabled = true
		upgrade_1_price.text = "out of stock"
	else:
		update_price_labels()


func _on_button_pressed_2() -> void:
	self.linked_distraction.upgrade_2()
	if(linked_distraction.upgrade_level_2_one_time == true or linked_distraction.upgrade_level_2_disabled):
		upgrade_2_button.disabled = true
		upgrade_2_price.text = "out of stock"
	else:
		update_price_labels()


func _on_button_pressed_3() -> void:
	self.linked_distraction.upgrade_3()
	if(linked_distraction.upgrade_level_3_one_time == true or linked_distraction.upgrade_level_3_disabled):
		upgrade_3_button.disabled = true
		upgrade_3_price.text = "out of stock"
	else:
		update_price_labels()


func _on_button_pressed_4() -> void:
	self.linked_distraction.upgrade_4()
	if(linked_distraction.upgrade_level_4_one_time == true or linked_distraction.upgrade_level_4_disabled):
		upgrade_4_button.disabled = true
		upgrade_4_price.text = "out of stock"
	else:
		update_price_labels()
		
