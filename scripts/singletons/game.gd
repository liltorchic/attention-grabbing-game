extends Node

var is_new_game: bool = true

#game stats
var time_points:float = 100000 if Constants.dev else 0
var isDataUnlocked = false
var cumlative_points:int = 0
var cumlative_points_rollover:int = 0
var base_mult:float = 0.0 #global multiplier
var multiplier:float = Constants.base_multiplier * 1.0
var hundredkprogess:int = 0 #second currency
var discount:float = 1.000
var lives:int = Constants.starting_lives

#unused
var isMultUnlocked = true
var isUpgradesUnlocked = true

#ui
var ui_decimal_count = 0
const panel_size:int = Constants.ui_panel_standard_size
var selected 

signal updated_selected
signal discount_purchased
signal data_purchased
signal game_loaded

func _ready() -> void:
	game_loaded.connect(_game_loaded)

func checkprogressandrollover():
	if cumlative_points_rollover >= 100000:
		cumlative_points_rollover -= 100000
		hundredkprogess += 1
		print("100k point")

# includes multiplier
func add_time_point():
	time_points += 1.0 * multiplier
	cumlative_points += 1.0 * multiplier
	cumlative_points_rollover += 1.0 * multiplier
	checkprogressandrollover()
	
# does not include multiplier
func add_time_points(_p:float):
	time_points += _p
	cumlative_points += _p
	cumlative_points_rollover += _p
	checkprogressandrollover()
	
func remove_time_points(_p:float):
	time_points -= _p

func get_points() -> float:
	return time_points

func add_life():
	lives += 1

func remove_life():
	if(lives - 1 > 0):
		lives -= 1
	else:
		print("you died")
	
func get_multiplier():
	return multiplier + base_mult

func add_to_multiplier( _f: float):
	multiplier =+ _f
	
func recalc_price(_in:float) -> float:
	return (_in * 1.25) + (100 * Game.multiplier)

func add_base_mult(_in:float):
	base_mult += _in
	
func set_selected(_in):
	selected = _in
	updated_selected.emit()
	
func doDataUpdate():
	isDataUnlocked = true
	data_purchased.emit()
	
func doDiscountUpdate():
	if(discount - 0.01 > 0):
		discount -= 0.01
		discount_purchased.emit()
	else:
		var button:Button = %Button_data_upgrade
		var label:Label = %Label_Price_data_upgrade
		button.disabled = true
		label.text = "out of stock"
		
@onready var stats_node: NodePath = "game/HBoxContainer/VBoxContainer_UI/ColorRect/container_scorer_ver"

const SAVE_PATH = "user://save_json.json"

func save_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var stats := get_node(stats_node)
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict := {
		stats = {
			time_points = var_to_str(time_points),
			isDataUnlocked = var_to_str(isDataUnlocked),
			cumlative_points = var_to_str(cumlative_points),
			cumlative_points_rollover = var_to_str(cumlative_points_rollover),
			base_mult = var_to_str(base_mult),
			multiplier = var_to_str(multiplier),
			hundredkprogess = var_to_str(hundredkprogess),
			discount = var_to_str(discount),
			lives = var_to_str(lives),
		},
		distractionz = [],
		shopItemz = [],
	}

	#gather data from nodes we generated
	#distraction nodes
	for d in get_tree().get_nodes_in_group("distraction"):
		save_dict.distractionz.push_back({
			data = d.getSaveData(),
		})
	
	#shop entries
	for s in get_tree().get_nodes_in_group("shopItem"):
		save_dict.shopItemz.push_back({
			data = s.getSaveData(),
		})

	file.store_line(JSON.stringify(save_dict))

func _game_loaded():
	if !is_new_game:
		print("loading saved game")
		load_game()
	else:
		print("loading new game")
		
		

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	#if there is no save file
	if(file == null):
		return
	
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	var shop_item_target = get_tree().get_first_node_in_group("shop_target")


	var shop_item_template =  preload("res://scenes/shop_item.tscn")
	var _distraction_clicker = preload("res://scenes/distractions/distraction_clicker.tscn")
	var _distraction_pet = preload("res://scenes/distractions/distraction_pet.tscn")
	var _distraction_ticker = preload("res://scenes/distractions/distraction_ticker.tscn")
	var _distraction_timer_button = preload("res://scenes/distractions/distraction_timer_button.tscn")
	var _distraction_timer_suprise = preload("res://scenes/distractions/distraction_timer_suprise.tscn")
	# Remove existing objects before adding new ones.
	get_tree().call_group("distraction", "queue_free")
	get_tree().call_group("upgradeItem", "queue_free")
	get_tree().call_group("shopItem", "queue_free")
	
	#populate game data
	time_points = str_to_var(save_dict.stats.time_points)
	cumlative_points = str_to_var(save_dict.stats.cumlative_points)
	cumlative_points_rollover = str_to_var(save_dict.stats.cumlative_points_rollover)
	base_mult = str_to_var(save_dict.stats.base_mult)
	hundredkprogess = str_to_var(save_dict.stats.hundredkprogess)
	discount = str_to_var(save_dict.stats.discount)
	lives = str_to_var(save_dict.stats.lives)
	multiplier = str_to_var(save_dict.stats.multiplier)
	isDataUnlocked = str_to_var(save_dict.stats.isDataUnlocked)

#for every saved distraction
	for distract: Dictionary in save_dict.distractionz:
		var distraction_ref
		var enumtype:Constants.Type = distract.data.type
		
		#select which type of distraction to create
		if(enumtype == Constants.Type.CLICKER):
			distraction_ref = _distraction_clicker
		elif(enumtype == Constants.Type.PET):
			distraction_ref = _distraction_pet
		elif(enumtype == Constants.Type.TICKER):
			distraction_ref = _distraction_ticker
		elif(enumtype == Constants.Type.TIMER_BUTTON):
			distraction_ref = _distraction_timer_button
		elif(enumtype == Constants.Type.TIMER_SUPRISE):
			distraction_ref = _distraction_timer_suprise
			
		var shop_item_template_instance:ShopItem = shop_item_template.instantiate()
		var item:Distraction = distraction_ref.instantiate()
		
		item.init()
		item.savedata = distract.data.stats.duplicate()
		
		shop_item_target.add_child(shop_item_template_instance)#add shop item to shop
		shop_item_template_instance.add_item(item)#add item to shop item
		
		shop_item_template_instance.set_title(str_to_var(distract.data.stats.title))
		shop_item_template_instance.set_price(str_to_var(distract.data.stats.price))
		
		
		print("added a d of type " + str((distract.data.type))) 
