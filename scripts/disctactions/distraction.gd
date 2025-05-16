#prototype class
#an interface if you will
extends ColorRect
class_name Distraction

var UI_MODE:bool = true
var LOG:bool = false

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree
@onready var upgrade = preload("res://scenes/upgrade_item.tscn")

var price = 1 * Game.get_multiplier()
var title = "undefined"
var upgrade_level_1 = 1
var upgrade_level_1_title = "undefined"
var upgrade_level_1_desc = "description"
var upgrade_level_1_startingprice:float = -1
var upgrade_level_1_type:Constants.Type = Constants.Type.UNDEFINED

var upgrade_level_2 = 1
var upgrade_level_2_title = "undefined"
var upgrade_level_2_desc = "description"
var upgrade_level_2_startingprice:float = -1
var upgrade_level_2_type:Constants.Type = Constants.Type.UNDEFINED

var upgrade_level_3 = 1
var upgrade_level_3_title = "undefined"
var upgrade_level_3_desc = "description"
var upgrade_level_3_startingprice:float = -1
var upgrade_level_3_type:Constants.Type = Constants.Type.UNDEFINED

var upgrade_level_4 = 1
var upgrade_level_4_title = "undefined"
var upgrade_level_4_desc = "description"
var upgrade_level_4_startingprice:float = -1
var upgrade_level_4_type:Constants.Type = Constants.Type.UNDEFINED

var amount:int = 0
var mult:float = 0

func update_upgrade_data():
	push_error("update_upgrade_data unimplemented")

func update_labels():
	push_warning("update_labels unimplemented")
	
func init():
	self.focus_mode = Control.FOCUS_CLICK
	push_error("init unimplemented")
	
func upgrade_1():
	push_warning("upgrade_1 unimplemented")
	
func upgrade_2():
	push_warning("upgrade_2 unimplemented")
	
func upgrade_3():
	push_warning("upgrade_3 unimplemented")
	
func upgrade_4():
	push_warning("upgrade_4 unimplemented")
