extends Node3D

@export var activee = true
@export var seferme = false
var ouvrable
var ouverte = false
var sauv_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	sauv_pos = $Area3D/Node3D2.position.z
	#$Area3D/CollisionShape3D.disabled = false
	$Area3D/StaticBody3D/CollisionShape3D.disabled = false
	

func ouvre():
	$Area3D/StaticBody3D/CollisionShape3D.disabled = true
	$AudioStreamPlayer3D.play()
	#$Area3D/CollisionShape3D.disabled = true
	$AnimationPlayer.play("ouvre")
	ouverte = true

func ferme():
	#$Area3D/CollisionShape3D.disabled = false
	$AudioStreamPlayer3D.play()
	$Area3D/StaticBody3D/CollisionShape3D.disabled = false
	$AnimationPlayer.play("ferme")
	ouverte = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if seferme == true:
		ferme()
		seferme = false
	if activee == true:
		if ouvrable:
			$Label3D.visible = true
			$Label3D2.visible = true
			if ouverte:
				if Input.is_action_just_pressed("E"):
					print("ferme")
					ferme()
			else:
				if Input.is_action_just_pressed("E"):
					print("ouvre")
					ouvre()
		else:
			$Label3D.visible = false
			$Label3D2.visible = false


func _on_area_3d_area_entered(_area):
	ouvrable = true


func _on_area_3d_area_exited(_area):
	ouvrable = false
