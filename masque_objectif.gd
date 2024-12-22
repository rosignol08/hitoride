extends Node3D

@export var ramasssable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ramasssable and Input.is_action_just_pressed("E"):
		Globale.masque_ramasse -= 1
		queue_free()


func _on_area_3d_area_entered(area):
	ramasssable = true
	$Label3D.show()



func _on_area_3d_area_exited(area):
	ramasssable = false
	$Label3D.hide()
