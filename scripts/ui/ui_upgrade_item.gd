extends Node

class_name upgrade_item

var loading_from_save:bool = false

@onready var title :Label = $ColorRect/VBoxContainer/Label_Title

@onready var highlight :ColorRect = $ColorRect

@onready var upgrade_1_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_upgrade
@onready var upgrade_1_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_description
@onready var upgrade_1_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Label_Price
@onready var upgrade_1_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Button
@onready var upgrade_1_container:HBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/level
@onready var upgrade_1_data_label:Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/level/Label

@onready var upgrade_2_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_upgrade
@onready var upgrade_2_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/Label_description
@onready var upgrade_2_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Label_Price
@onready var upgrade_2_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/HBoxContainer/Button
@onready var upgrade_2_container:HBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/level
@onready var upgrade_2_data_label:Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_2/level/Label

@onready var upgrade_3_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_upgrade
@onready var upgrade_3_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/Label_description
@onready var upgrade_3_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Label_Price
@onready var upgrade_3_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/HBoxContainer/Button
@onready var upgrade_3_container:HBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/level
@onready var upgrade_3_data_label:Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_3/level/Label

@onready var upgrade_4_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_upgrade
@onready var upgrade_4_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/Label_description
@onready var upgrade_4_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Label_Price
@onready var upgrade_4_button :Button = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/HBoxContainer/Button
@onready var upgrade_4_container:HBoxContainer = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/level
@onready var upgrade_4_data_label:Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_4/level/Label

var linked_distraction:Distraction

var is_selected:bool = false

func _ready() -> void:
	self.title.text = str(linked_distraction.get_title())
	upgrade_1_button.pressed.connect(update_price_labels)
	upgrade_2_button.pressed.connect(update_price_labels)
	upgrade_3_button.pressed.connect(update_price_labels)
	upgrade_4_button.pressed.connect(update_price_labels)
	if(Game.isDataUnlocked):
		_data_purchased()
	else:
		update_price_labels()
	
	if(self.loading_from_save):
		self.linked_distraction.upgrade_ui_loaded.emit()

func loadSaveData(_in:Dictionary):
	pass

func link(input):
	self.linked_distraction = input
	self.focus_mode = Control.FOCUS_NONE
	Game.updated_selected.connect(_selection_update)
	Game.discount_purchased.connect(_discount_update)
	Game.data_purchased.connect(_data_purchased)
		
func update_price_labels():
	
	upgrade_1_title.text = linked_distraction.upgrade_level_1_title
	upgrade_1_desc.text = linked_distraction.upgrade_level_1_desc
	if(upgrade_1_price.text != "out of stock"):
		upgrade_1_price.text = str("%.2f" % [linked_distraction.upgrade_level_1_price * Game.discount])
	
	upgrade_2_title.text = linked_distraction.upgrade_level_2_title
	upgrade_2_desc.text = linked_distraction.upgrade_level_2_desc
	if(upgrade_2_price.text != "out of stock"):
		upgrade_2_price.text = str("%.2f" % [linked_distraction.upgrade_level_2_price * Game.discount])
	
	upgrade_3_title.text = linked_distraction.upgrade_level_3_title
	upgrade_3_desc.text = linked_distraction.upgrade_level_3_desc
	if(upgrade_3_price.text != "out of stock"):
		upgrade_3_price.text = str("%.2f" % [linked_distraction.upgrade_level_3_price * Game.discount])
	
	upgrade_4_title.text = linked_distraction.upgrade_level_4_title
	upgrade_4_desc.text = linked_distraction.upgrade_level_4_desc
	if(upgrade_4_price.text != "out of stock"):
		upgrade_4_price.text = str("%.2f" % [linked_distraction.upgrade_level_4_price * Game.discount])
		
	upgrade_1_data_label.text = linked_distraction.upgrade_level_1_level_string
	upgrade_2_data_label.text = linked_distraction.upgrade_level_2_level_string
	upgrade_3_data_label.text = linked_distraction.upgrade_level_3_level_string
	upgrade_4_data_label.text = linked_distraction.upgrade_level_4_level_string
	
	
	
func _selection_update():
	if Game.selected == linked_distraction:
		is_selected = true
		highlight.color = Color(0.466, 0.466, 0.466)
	else:
		is_selected = false
		highlight.color = Color(0.588, 0.588, 0.588)

func _discount_update():
		update_price_labels()

		
func _data_purchased():
		upgrade_1_container.visible = true
		upgrade_2_container.visible = true
		upgrade_3_container.visible = true
		upgrade_4_container.visible = true
		update_price_labels()

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
		
