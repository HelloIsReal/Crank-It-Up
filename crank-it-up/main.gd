extends Node2D

var notes = [
	[2, 8,],
	[3, 8],
	[4, 9],
	[5, 10]
]
var cameraTween = [
	[1],#type of tween
	[4]# the beat it will happen
]

var score := 0

var lastJudgement="none"

func _ready():
	Globals.gameplayScrollSpeed=Globals.scrollSpeed
	Globals.cameraTween.emit(1,5)
	#await get_tree().create_timer(2).timeout
	#scrollSpeed=2

func _process(delta):
	#$Camera2D.rotate(deg_to_rad(10) * delta)
	queue_redraw()
	for i in (4):
		var lane = notes[i]
		while not lane.is_empty():
			var note = lane[0]
			if note < $Conductor.beat - 0.5:
				lane.pop_front()
			else:
				break

# Called when the node enters the scene tree for the first time.
func _draw():
	for i in (5): 
		var start = Vector2(100 * i + 200, -3000)
		var end = Vector2(100 * i + 200, 3000)
		draw_line(start, end, Color.WHITE)
		if i < 4:
			var label_pos = Vector2(100 * (i+0.5) + 200, 620 + 30)
			draw_string(ThemeDB.fallback_font, label_pos, str(i+1), HORIZONTAL_ALIGNMENT_CENTER)
		
		var judge_start = Vector2(200,620)
		var judge_end = Vector2(100 * 4 + 200, 620)
		draw_line(judge_start, judge_end, Color.WHITE)
	if(lastJudgement=="perfect"):
		draw_string(ThemeDB.fallback_font, Globals.judgementTextPosition, "Perfect!", HORIZONTAL_ALIGNMENT_CENTER, 100, 24, Color.YELLOW)
	elif(lastJudgement=="great"):
		draw_string(ThemeDB.fallback_font, Globals.judgementTextPosition, "Great!", HORIZONTAL_ALIGNMENT_CENTER, 100, 24, Color.GREEN)
	else:
		draw_string(ThemeDB.fallback_font, Globals.judgementTextPosition, "....", HORIZONTAL_ALIGNMENT_CENTER, 100, 24, Color.GREEN)
		
		
	
	for i in (4):
		#print($Conductor.beat)
		for note in notes[i]:
			var y = 620 + ((Globals.gameplayScrollSpeed*10) * ($Conductor.beat - note))
			#print($Conductor.beat)
			var start = Vector2(100 * i + 200, y)
			var end = Vector2(100 * (i+1) + 200, y)
			draw_line(start, end, Color.WHITE, 10)
	draw_string(ThemeDB.fallback_font, Vector2(60,60), "Score: " + str(score))
	


	

func _unhandled_key_input(event: InputEvent):
	if(event.is_action_pressed("1")):
		_handle_lane_press(0)
	elif(event.is_action_pressed("2")):
		_handle_lane_press(1)
	elif(event.is_action_pressed("3")):
		_handle_lane_press(2)
	elif(event.is_action_pressed("4")):
		_handle_lane_press(3)
	
func _handle_lane_press(lane: int):
	var lane_notes = notes[lane]
	if lane_notes.is_empty():
		return
	
	var note = lane_notes[0]
	
	if abs($Conductor.beat - note) < 0.4:
		if abs($Conductor.beat - note) < 0.1:
			score+=2
			lastJudgement="perfect"
			#draw_string(ThemeDB.fallback_font, Vector2(60,70), "Perfect!")
			#draw_string(ThemeDB.fallback_font, Vector2(60,70), "Perfect!", HORIZONTAL_ALIGNMENT_LEFT, 30, 24, Color.YELLOW)
		else:
			score+=1
			lastJudgement="great"
			
		lane_notes.pop_front()
		
