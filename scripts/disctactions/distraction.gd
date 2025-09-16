#prototype class
#an interface if you will
extends ColorRect
class_name Distraction

var UI_MODE:bool = true
var LOG:bool = false

@onready var p = preload("res://scenes/particle.tscn")
var particle_tree
@onready var upgrade = preload("res://scenes/upgrade_item.tscn")

var price:float = 1 * Game.get_multiplier()
var title:String = "undefined"

var upgrade_level_1_title:String = "undefined"
var upgrade_level_1_desc:String = "description"
var upgrade_level_1_price:float = -1
var upgrade_level_1_price_increase:float = -1
var upgrade_level_1_one_time:bool = false
var upgrade_level_1_level:int = 0
var upgrade_level_1_level_limit:int = 1
var upgrade_level_1_level_string:String = "-/-"
var upgrade_level_1_disabled:bool = false

var upgrade_level_2_title = "undefined"
var upgrade_level_2_desc = "description"
var upgrade_level_2_price:float = -1
var upgrade_level_2_price_increase:float = -1
var upgrade_level_2_one_time:bool = false
var upgrade_level_2_level:int = 0
var upgrade_level_2_level_limit:int = 1
var upgrade_level_2_level_string:String = "-/-"
var upgrade_level_2_disabled:bool = false

var upgrade_level_3_title = "undefined"
var upgrade_level_3_desc = "description"
var upgrade_level_3_price:float = -1
var upgrade_level_3_price_increase:float = -1
var upgrade_level_3_one_time:bool = false
var upgrade_level_3_level:int = 0
var upgrade_level_3_level_limit:int = 1
var upgrade_level_3_level_string:String = "-/-"
var upgrade_level_3_disabled:bool = false

var upgrade_level_4_title = "undefined"
var upgrade_level_4_desc = "description"
var upgrade_level_4_price:float = -1
var upgrade_level_4_price_increase:float = -1
var upgrade_level_4_one_time:bool = false
var upgrade_level_4_level:int = 0
var upgrade_level_4_level_limit:int = 1
var upgrade_level_4_level_string:String = "-/-"
var upgrade_level_4_disabled:bool = false

var amount:float
var mult:float
var auto:bool
var autofreq:float
var alarm:bool

func update_labels():
	push_error("update_labels unimplemented")
	
func init():
	push_error("init unimplemented")
	
func upgrade_1():
	push_warning("upgrade_1 unimplemented")
	
func upgrade_2():
	push_warning("upgrade_2 unimplemented")
	
func upgrade_3():
	push_warning("upgrade_3 unimplemented")
	
func upgrade_4():
	push_warning("upgrade_4 unimplemented")
