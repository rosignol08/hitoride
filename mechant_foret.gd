extends Node3D
var random_event = 0
var can_generate = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite3D.play("gif")
	$AudioStreamPlayer3D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_generate == true:
		can_generate = false
		
		random_event = randi()
		if (random_event %5 == 0):
			$Timer.start()
			$AudioStreamPlayer3D2.play()
		if (random_event %6 == 0):
			$Timer.start()
			$AudioStreamPlayer3D.play()
	

func _on_timer_timeout():
	can_generate = true
