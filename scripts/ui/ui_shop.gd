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
		var item:Distraction = i.instantiate()
		item.init()
		target.add_child(shop_item)#add shop item to shop
		shop_item.add_item(i)#add item to shop item
		shop_item.set_title(item.title)
		shop_item.set_price(item.price)
		shop_item.bought.connect(_child_button_pressed)
		
		
func _child_button_pressed(packedscene: PackedScene):
	var distraction:Distraction = packedscene.instantiate()
	distraction.UI_MODE = false
	distractions.add_child(distraction)
	print("bought " + str(distraction))
	
	
