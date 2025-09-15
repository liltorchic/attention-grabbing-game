extends VBoxContainer


var lives_label_data:Label
var score_label_data:Label
var mult_label_data:Label


func _ready() -> void:
	lives_label_data = get_node("container_lives_hor/Label_Lives_num")
	lives_label_data.text = ""
	score_label_data = get_node("container_points_hor/Label_Points_num")
	score_label_data.text = ""
	mult_label_data = get_node("container_mult_hor/Label_Multiplier")
	mult_label_data.text = ""
	
func _process(delta: float) -> void:
	if(str(Game.lives) != lives_label_data.text):
		lives_label_data.text = str(Game.lives)
		
	if(str(Game.time_points) != score_label_data.text):
		score_label_data.text = str("%.3f" % [Game.time_points])
		
	if(Game.isMultUnlocked):
		if(str(Game.get_multiplier()) != mult_label_data.text):
			mult_label_data.text = "x" + str(Game.get_multiplier())
	else:
		mult_label_data.text = ""
