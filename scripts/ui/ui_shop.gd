extends ColorRect

@onready var shop_item_template =  preload("res://scenes/shop_item.tscn")
@onready var distractions = $"../../../../ColorRect/ScrollContainer/distractions"
@onready var target = $ScrollContainer/GridContainer

@onready var _distraction_clicker = preload("res://scenes/distractions/distraction_clicker.tscn")
@onready var _distraction_pet = preload("res://scenes/distractions/distraction_pet.tscn")
@onready var _distraction_ticker = preload("res://scenes/distractions/distraction_ticker.tscn")
@onready var _distraction_timer_button = preload("res://scenes/distractions/distraction_timer_button.tscn")
@onready var _distraction_timer_suprise = preload("res://scenes/distractions/distraction_timer_suprise.tscn")

@onready var shop_items=[_distraction_clicker,
				_distraction_pet,
				_distraction_ticker,
				_distraction_timer_button,
				_distraction_timer_suprise]
				

func _ready() -> void:
	for i in shop_items:
		var shop_item:ShopItem = shop_item_template.instantiate()
		#container.add_child(_in)
		shop_item.add_item(i)
		var item:Distraction = i.instantiate()
		target.add_child(shop_item)
		shop_item.add_item(i)
		shop_item.bought.connect(_child_button_pressed)
		shop_item.item_ready.connect(_update_info.bind(shop_item))
		
		
func _child_button_pressed(item):
	var distraction:Distraction = item.instantiate()
	distraction.UI_MODE = false
	distractions.add_child(distraction)
	print("bought " + str(distraction))
	
func _update_info(item:Distraction, shop_item:ShopItem):
	shop_item.set_title(item.title)
	shop_item.set_price(item.price)
