extends TextureRect

var t: float = 0.0  # time tracker
var base_scale := 2.4       # default size
var beat_strength := 0.05           # how much it scales up
var bpm := 36.0                     # beats per minute


func _process(delta: float) -> void:
	t += delta  # accumulate time
	var value = base_scale + 0.01 * sin(t)  # oscillates between 1.9 and 2.9
	self.scale = Vector2(value,value)
	self.rotation = 0.01 * sin(t * 0.2)
	
	# --- Heartbeat ---
	var beat_freq = bpm / 60.0  
	# First quick beat
	var beat1 = exp(-8.0 * fposmod(t * beat_freq, 2.0)) * sin(t * beat_freq * PI * 3.0)
	# Second quick beat (slightly delayed)
	var beat2 = exp(-8.0 * fposmod(t * beat_freq - 0.2, 2.0)) * sin((t * beat_freq - 0.2) * PI * 3.0)

	var heartbeat = ((beat1 + beat2) * beat_strength) * .50 + 1
	self.scale *= heartbeat
