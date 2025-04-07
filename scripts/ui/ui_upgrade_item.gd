extends Node

class_name upgrade_item

@onready var title :Label = $ColorRect/VBoxContainer/Label_Title
@onready var upgrade_1_title :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_upgrade
@onready var upgrade_1_desc :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/Label_description
@onready var upgrade_1_price :Label = $ColorRect/VBoxContainer/HBoxContainer/upgrade_1/HBoxContainer/Label_Price


var linked_distraction:Distraction

func link(input):
	linked_distraction = input
	title.text = str(linked_distraction)
	upgrade_1_title.text = linked_distraction.upgrade_level_1_title
	upgrade_1_desc.text = linked_distraction.upgrade_level_1_desc
	upgrade_1_price.text = str(linked_distraction.upgrade_level_1_startingprice)
	
