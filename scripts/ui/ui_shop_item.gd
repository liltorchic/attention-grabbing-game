extends Control
class_name ShopItem

var container:Control
var label_title:Label
var label_price:Label

var distraction:PackedScene
var copy:Distraction
var copy2:Distraction

var id
var price: int
var count: int

signal bought(packedscene)

func tether() -> void:
	print("linking " + id)
	if(id == "clicker"):	
		Game.shop_item_clicker_loaded.emit(self)
	elif(id == "pet"):
		Game.shop_item_pet_loaded.emit(self)
	elif(id == "ticker"):
		Game.shop_item_ticker_loaded.emit(self)
	elif(id == "timer"):
		Game.shop_item_timer_button_loaded.emit(self)
	elif(id == "bomb"):
		Game.shop_item_timer_defuse_loaded.emit(self)
	
func loadSaveData(_in:Dictionary):
	print("loading in data for shop item " + self.id)
	self.price = _in.price
	self.count = _in.count
	label_price = get_node("ColorRect/VBoxContainer/HBoxContainer/Label_Price")
	label_price.text = str("%.0f" % [self.price])
	var distraction_target = get_node("ColorRect/VBoxContainer/Container/ColorRect")	
	distraction_target.add_child(	distraction.instantiate())
	
#gather all info to be saved
func getSaveData() -> Dictionary:
	var save_dict := {
		stats = {
			id = var_to_str(self.id),
			price = var_to_str(self.price),
			count = var_to_str(self.count),
		},
	}
	return save_dict

func add_item(_in:PackedScene):
	container = get_node("ColorRect/VBoxContainer/Container")
	var distraction_target = get_node("ColorRect/VBoxContainer/Container/ColorRect")
	distraction = _in
	var lilguy:Distraction = _in.instantiate()
	lilguy.init()
	lilguy.UI_MODE = true
	distraction_target.add_child(	lilguy)
	Game.discount_purchased.connect(_discount_purchased)
	
func _discount_purchased():
	set_price(price * Game.discount)
	
func set_title(_in:String):
	label_title = get_node("ColorRect/VBoxContainer/Label_Title")
	label_title.text = _in
	id = _in
	
func set_price(_in):
	label_price = get_node("ColorRect/VBoxContainer/HBoxContainer/Label_Price")
	label_price.text = str("%.0f" % [_in])
	price = _in

func _on_button_pressed() -> void:
	if(price * Game.discount <= Game.time_points):
		Game.remove_time_points(price * Game.discount)
		set_price(Game.recalc_price(price * Game.discount))
		count += 1
		bought.emit(distraction)
