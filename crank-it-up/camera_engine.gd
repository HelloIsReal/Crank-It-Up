extends Node2D

@onready var camera = $"../camera"

func _ready():
	Globals.cameraTween.connect(camTween)
	camera.position = Vector2(640,360)



#func _process(delta):
	#pass
func camTween(type,length):
	if(type==1): #camera spin
		
		var spinLength = 360/length
		print(spinLength)
		for i in spinLength:
			await get_tree().create_timer(spinLength).timeout
			print("spin!")
			camera.rotate(deg_to_rad(spinLength) * get_physics_process_delta_time())
