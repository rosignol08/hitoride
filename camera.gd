class_name FreeLookCamera extends Camera3D

var _prev_mouse_position = Vector2()
var mouse_position = Vector2()

# Modifier keys' speed multiplier
const SHIFT_MULTIPLIER = 2.5
const ALT_MULTIPLIER = 1.0 / SHIFT_MULTIPLIER

@export_range(0.0, 1.0) var sensitivity = 0.05

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 25.0

# Movement state
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _acceleration = 30
var _deceleration = -10
var _vel_multiplier = 4

# Keyboard state
var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
		_prev_mouse_position = get_viewport().get_mouse_position #modifié
func _ready():
	_prev_mouse_position = get_viewport().get_mouse_position #modifié
	if get_tree().paused == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Updates mouselook and movement every frame
func _process(delta):
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if get_tree().paused == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		_update_mouselook()
		_update_movement(delta)

# Updates camera movement
func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3((_d as float) - (_a as float), 
						(_e as float) - (_q as float), 
						(_s as float) - (_w as float))
	
	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * _acceleration * _vel_multiplier * delta \
		+ _velocity.normalized() * _deceleration * _vel_multiplier * delta
	
	# Compute modifiers' speed multiplier
	var speed_multi = 1
	if _shift: speed_multi *= SHIFT_MULTIPLIER
	if _alt: speed_multi *= ALT_MULTIPLIER
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
	
		translate(_velocity * delta * speed_multi)


func _update_mouselook2():
	# Multiplie la position de la souris par la sensibilité
	_mouse_position *= sensitivity
	var yaw = _mouse_position.x  # Rotation horizontale
	var pitch = _mouse_position.y  # Rotation verticale 
	_mouse_position = Vector2(0, 0)  # Réinitialise la position de la souris
	# Empêche de regarder trop haut ou trop bas (pitch est vertical)
	var max_pitch = 90.0
	var min_pitch = -90.0
	pitch = clamp(pitch, min_pitch - _total_pitch, max_pitch - _total_pitch)
	_total_pitch += pitch    
	# Applique la rotation à la caméra
	rotate_y(deg_to_rad(-yaw))  # Rotation horizontale (axe Y)
	rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-pitch))  # Rotation verticale (axe X)


# Updates mouse look
func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	_mouse_position *= sensitivity
	var yaw = _mouse_position.x
	var pitch = _mouse_position.y
	_mouse_position = Vector2(0, 0)
	
	# Prevents looking up/down too far
	pitch = clamp(pitch, -60 - _total_pitch, 90 - _total_pitch)
	_total_pitch += pitch

	rotate_y(deg_to_rad(-yaw))
	rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))
