extends AudioStreamPlayer

@export var bpm = 100
var beat := 0.0

func _process(delta):
	beat = get_playback_position() * bpm / 60
