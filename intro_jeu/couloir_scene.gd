extends Node3D

var prenable = false
var ramasse_cassette = false
var entree = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CharacterBody3D/Camera3D2.make_current()
	$Sketchfab_Scene2/Label3D.hide()
	$Label3D.hide()
	prenable = false
	ramasse_cassette = false
	#var couleur = Vector4(0,0,0.647,0.761)
	#$CanvasLayer2/ColorRect.color = couleur
	$AnimationPlayer.play("ouverte")
	print("ouvre")
	if Globale.a_cassette == true:
		$Sketchfab_Scene2.hide()

var boolen_porte = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print("dounia",Globale.a_cassette)
	if prenable:
		if Input.is_action_just_pressed("E") and boolen_porte == false:
			boolen_porte = true
			ramasse_cassette = true
			$Sketchfab_Scene2.hide()
			Globale.a_cassette = true
	if entree:
		if Input.is_action_just_pressed("E") and Globale.a_cassette == true:
			boolen_porte = true
			preload("res://intro_jeu/room_debut.tscn")
			$AudioStreamPlayer.play()
			$AnimationPlayer.play("porte_ferme")


func _on_area_3d_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Sketchfab_Scene2/Label3D.show()
	prenable = true


func _on_area_3d_2_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	if ramasse_cassette:
		$Label3D.show()
		entree = true

func _on_area_3d_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Sketchfab_Scene2/Label3D.hide()


func _on_area_3d_2_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Label3D.hide()
	prenable = false
	entree = false


func _on_audio_stream_player_finished():
	boolen_porte = false
	get_tree().change_scene_to_file("res://intro_jeu/room_debut.tscn")
