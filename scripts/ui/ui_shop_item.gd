extends Control
class_name ShopItem

var container:Control
var label_title:Label
var label_price:Label

var distraction:PackedScene
var copy:Distraction

var id
var price: int
var count: int

signal bought(packedscene)

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

func add_item(_in):
	
	container = get_node("ColorRect/VBoxContainer/Container")
	distraction = _in
	copy = distraction.instantiate()
	container.add_child(copy)
	id = copy.get_instance_id()
	Game.discount_purchased.connect(_discount_purchased)
	
	if(!Game.is_new_game):
		var distraction_target = get_tree().get_first_node_in_group("distraction_target")
		copy.UI_MODE = false
		distraction_target.add_child(copy)
	
func _discount_purchased():
	set_price(price * Game.discount)
	
func set_title(_in:String):
	label_title = get_node("ColorRect/VBoxContainer/Label_Title")
	label_title.text = _in
	
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
