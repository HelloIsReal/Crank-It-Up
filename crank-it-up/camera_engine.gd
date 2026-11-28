extends Node2D

@onready var camera = $"../camera"

func _ready():
	Globals.cameraTween.connect(camTween)
	camera.position = Vector2(640,360)



#func _process(delta):
	#pass
func camTween(type,length):
	if(type==1): #camera spin
		var timeTaken=0 # stopwatch that goes up till it reaches length
		var currentCameraRotation = camera.rotation
		#var spinLength = 360/length
		#print(spinLength)
		while(timeTaken<length): # repeats until time taken is same as length
			var deltaTime = get_physics_process_delta_time() # delta time for timeTaken and length
			timeTaken+=deltaTime
			camera.rotate(deg_to_rad(360.0/length) * deltaTime)
			#rotates by a full rotation divided by length. So it rotates slow enough for the length
			
			await get_tree().process_frame
			print("spin!")
		camera.rotation = currentCameraRotation
			
