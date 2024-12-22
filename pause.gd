extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")

func pausee():
	$AnimationPlayer.play("blur")
	get_tree().paused = true

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func test_echape():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pausee()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	test_echape()

func _on_recommencer_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_menu_pressed():
	#get_tree().change_scene_to_file("res://menu_2d.tscn")
	get_tree().quit


func _on_reprendre_pressed():
	resume()
