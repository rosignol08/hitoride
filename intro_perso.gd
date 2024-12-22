extends CharacterBody3D

var speed = 2.0
var multiplieur = 1
var affiche_conseil_bougie : bool = false
var peut_afficher_consei_bougie : bool = true
var current_label = null  # Stocker le label actuel
var marche_sur_herbe = false 
var marche_sur_bois = false
@onready var previous_position = Vector3.ZERO  # Stocke la position précédente
@onready var is_moving = false  # Flag pour savoir si on bouge
var musique_bois = load("res://song/wook_plank_song.wav")
var musique_herbe = load("res://song/Herbe_marche.wav")
var dico_truc_a_dire = ["on m as dit de visiter cette foret le matin "]

func _ready():
	# Initialiser la position précédente à la position actuelle
	previous_position = global_transform.origin

func affiche_conseil(label: Label):
	if peut_afficher_consei_bougie:
		peut_afficher_consei_bougie = false
		# Affiche le label
		label.visible = true
		current_label = label
		# Démarre un timer pour cacher le label après un certain temps
		$Timer2.start()


func _process(delta):
	velocity = Vector3()

	# Récupère la direction de la caméra
	var cam_transform = $Camera3D2.global_transform  # Utilise la transformation globale de la caméra
	var cam_forward = -cam_transform.basis.z  # Vecteur avant de la caméra
	var cam_right = cam_transform.basis.x  # Vecteur droit de la caméra

	# Ignore l'axe Y pour maintenir le mouvement sur un plan horizontal
	cam_forward.y = 0
	cam_right.y = 0

	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()

	if Input.is_action_pressed("avance"):
		if Input.is_action_pressed("cours"):
			speed = 5
		else:
			speed = 2.0
		velocity += cam_forward * speed  # Avancer dans la direction de la caméra

	if Input.is_action_pressed("recule"):
		if Input.is_action_pressed("cours"):
			speed = 5
		else:
			speed = 2.0
		velocity -= cam_forward * speed  # Reculer dans la direction de la caméra

	# Appliquer la gravité et les collisions
	velocity.y -= 100 * delta
	move_and_slide()
	# Récupérer la position actuelle du personnage
	var current_position = global_transform.origin
	# Comparer la position actuelle avec la position précédente
	if current_position.distance_to(previous_position) > 0.005:  # Petit seuil pour éviter les mouvements imperceptibles
		is_moving = true
		if $AudioStreamPlayer.playing == false:
			$AudioStreamPlayer.play()
	else:
		is_moving = false
		if $AudioStreamPlayer.playing == true:
			$AudioStreamPlayer.stop()
	# Mettre à jour la position précédente
	previous_position = current_position

func _on_audio_stream_player_finished():
	if is_moving:
		$AudioStreamPlayer.play()

