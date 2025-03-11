extends VBoxContainer


var lives_label_data:Label
var score_label_data:Label


func _ready() -> void:
	lives_label_data = get_node("HBoxContainer/Label_Lives_num")
	lives_label_data.text = ""
	score_label_data = get_node("HBoxContainer2/Label_Points_num")
	score_label_data.text = ""
	
func _process(delta: float) -> void:
	if(str(Game.lives) != lives_label_data.text):
		lives_label_data.text = str(Game.lives)
		
	if(str(Game.time_points) != score_label_data.text):
		score_label_data.text = str(Game.time_points)
