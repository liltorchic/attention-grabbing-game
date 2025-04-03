extends Control
class_name ShopItem

var container:Control
var label_title:Label
var label_price:Label

var distraction:PackedScene
var copy:Distraction

var id
var price: int

signal bought(packedscene)


func add_item(_in):
	container = get_node("ColorRect/VBoxContainer/Container")
	distraction = _in
	copy = distraction.duplicate().instantiate()
	container.add_child(copy)
	id = copy.get_instance_id()
	
	
func set_title(_in:String):
	label_title = get_node("ColorRect/VBoxContainer/Label_Title")
	label_title.text = _in
	
func set_price(_in):
	label_price = get_node("ColorRect/VBoxContainer/HBoxContainer/Label_Price")
	label_price.text = str(_in)
	price = _in

func _on_button_pressed() -> void:
	if(price <= Game.time_points):
		bought.emit(distraction)
		Game.remove_time_points(price)
