extends OmniLight3D
@export var noise : NoiseTexture3D
@export var noise2 : NoiseTexture3D
var time_passed := 0.0
var sampled_noise 
var amplitude = 0.1  # Amplitude du mouvement

#Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	sampled_noise = noise.noise.get_noise_1d(time_passed)
	#print(sampled_noise)
	if 0.5+sampled_noise > 0.1:
		light_energy = 0.5+sampled_noise
	
	#Sample noise for each axis
	var noise_x = noise2.noise.get_noise_1d(time_passed)
	var noise_y = noise2.noise.get_noise_1d(time_passed + 100)  #Offset to get different noise
	var noise_z = noise2.noise.get_noise_1d(time_passed + 200)  #Offset to get different noise
	#Apply noise to position
	var new_position = Vector3(noise_x * amplitude,noise_y * amplitude,noise_z * amplitude)
	#Update the position of the light
	global_transform.origin += 0.0005*new_position
