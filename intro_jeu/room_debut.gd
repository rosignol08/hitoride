extends Node3D

var entree = false
var lance_cinematique = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.hide()
	$Label3D2.hide()
	$CharacterBody3D/Camera3D2.make_current()
	if Globale.a_cassette == false :
		$Timer.start()

var boolen_porte = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print("dounia",Globale.a_cassette)
	if entree:
		if Input.is_action_just_pressed("E") and boolen_porte == false:
			boolen_porte = true
			print("on change de scene")
			$AudioStreamPlayer.play()
			$AnimationPlayer.play("fondue")
	if lance_cinematique:
		if Globale.a_cassette == true:
			if Input.is_action_just_released("E") and boolen_porte == false:
				boolen_porte = true
				$CharacterBody3D.queue_free()
				$Camera3D.make_current()
				$AnimationPlayer.play("rapproche_tele")
				$Timer2.start()


func _on_area_3d_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Label3D.show()
	entree = true


func _on_area_3d_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Label3D.hide()
	entree = false



func _on_timer_timeout():
	$AudioStreamPlayer3D.play()
	


func _on_audio_stream_player_finished():
	boolen_porte = false
	get_tree().change_scene_to_file("res://intro_jeu/couloir_scene.tscn")


func _on_area_3d_3_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	if Globale.a_cassette:
		$Label3D2.show()
		lance_cinematique = true
		preload("res://ecrant_transition.tscn")


func _on_area_3d_3_area_shape_exited(_area_rid, _area, _area_shape_index, _local_shape_index):
	$Label3D2.hide()
	lance_cinematique = false


func _on_timer_2_timeout():
	Globale.numero_scene = 0
	get_tree().change_scene_to_file("res://ecrant_transition.tscn")
