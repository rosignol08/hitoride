extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.hide()
	Globale.activer = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Label3D.show()
	if Input.is_action_just_pressed("E"):
		Globale.activer = true
		print("active")
