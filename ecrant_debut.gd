extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globale.a_cassette = false
	preload("res://intro_jeu/room_debut.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://intro_jeu/room_debut.tscn")


func _on_button_2_pressed():
	pass # Replace with function body.


func _on_button_3_pressed():
	get_tree().quit
