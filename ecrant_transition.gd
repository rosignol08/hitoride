extends Control

@onready var label = $CanvasLayer2/Label5  # Remplace par le chemin vers ton Label si besoin
var time = 0
var timer_on = false
var elapsed_time : float = 0.0  # Temps écoulé

var titre_scene = ["HITORIDE","l ouie","la vue","la peur","fin ?"]
var next_scene = null  # Pour stocker la prochaine scène préchargée
# Récupère le numéro de la scène depuis le singleton Global
var numero_scene = Globale.numero_scene
#.text =
# Called when the node enters the scene tree for the first time.
func _ready():
	if (numero_scene == 0):
		$CanvasLayer2/Label.text = titre_scene[0]
		preload("res://intro_jeu/introduction.tscn")
	elif (numero_scene == 1):
		$CanvasLayer2/Label.text = titre_scene[1]
		# Précharger la prochaine scène en arrière-plan
		preload("res://scene_foret.tscn")
	elif (numero_scene == 2):
		$CanvasLayer2/Label.text = titre_scene[2]
		preload("res://maison.tscn")
	else :
		$CanvasLayer2/Label.text = titre_scene[3]
	$CanvasLayer2.hide()
	$Timer.start()
	$AudioStreamPlayer.play()
	$ColorRect.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_on:
		time += delta
	var secondes = fmod(time,60)
	var minutes = fmod(time, 3600)/60
	var temps_passe = "%02d : %02d" % [minutes,secondes]
	label.text = temps_passe  # Affiche le temps 
	if (secondes > 10):
		timer_on = false
		if (numero_scene == 0):
			get_tree().call_deferred("change_scene_to_file", "res://intro_jeu/introduction.tscn")
		elif (numero_scene == 1):
			get_tree().call_deferred("change_scene_to_file", "res://scene_foret.tscn")
			#get_tree().call_deferred("change_scene_to_file", next_scene)
		elif (numero_scene == 2):
			get_tree().call_deferred("change_scene_to_file", "res://maison.tscn")
			#$CanvasLayer2/Label.text = titre_scene[2]
		else :
			$CanvasLayer2/Label.text = titre_scene[3]
func _on_timer_timeout():
	$ColorRect.hide()
	$CanvasLayer2.show()
	timer_on = true
#snappedf(elapsed_time, 0.01)


func _on_audio_stream_player_finished():
	pass # Replace with function body.
