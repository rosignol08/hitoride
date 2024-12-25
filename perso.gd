extends CharacterBody3D

var speed = 2.0
var multiplieur = 1
var allume
var elec = true
var niveau_batterie = 5
@export var ramasse = false
@export var bougie_ramassee = 0
@export var bougie : bool = false
var bougie_range : bool = true
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
	$Label_maison.hide()
	# Initialiser la position précédente à la position actuelle
	previous_position = global_transform.origin
	allume = true
	$Timer.start()
	$Label_bougie.hide()
	$Label_maison.hide()
	bougie = false
	if Globale.numero_scene == 2:
		$Label_maison.show()

func affiche_conseil(label: Label):
	if peut_afficher_consei_bougie:
		peut_afficher_consei_bougie = false
		# Affiche le label
		label.visible = true
		current_label = label
		# Démarre un timer pour cacher le label après un certain temps
		$Timer2.start()


func _process(delta):
	$Label_maison.text = str(bougie_ramassee) + "bougies ramassées"
	if bougie == true:
		#print("on a la bougie")
		affiche_conseil_bougie = true
	if bougie == true and bougie_range == false:
		$Camera3D2/AnimatableBody3D.visible = true
	else:
		$Camera3D2/AnimatableBody3D.visible = false
	$Control/TextureProgressBar.value = niveau_batterie
	if niveau_batterie == 0:
		elec = false
		$Camera3D2/SpotLight3D.light_energy = 0.0
	else:
		elec = true
	if ramasse:
		niveau_batterie += 1
		ramasse = false
	if affiche_conseil_bougie:
		affiche_conseil($Label_bougie)
	#pour la lumière
	if Input.is_action_just_pressed("lumiere"):# touche : T
		if allume == true:#eteint
			#print("eteindre")
			$Camera3D2/SpotLight3D.light_energy = 0.0
			allume = false
			$Timer.paused = true
		elif allume == false and elec == true:# touche : T
			#print("allumage")
			$Camera3D2/SpotLight3D.light_energy = 3.0
			allume = true
			$Timer.paused = false
	if Input.is_action_just_pressed("R"):
		if bougie:
			if bougie_range:
				bougie_range = false
			else:
				bougie_range = true
		else:
			pass
	if (elec == false):
		allume = false
		$Timer.paused = true
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
				speed = 5.0
				#print("court")
		else:
			speed = 2.0
		velocity += cam_forward * speed  # Avancer dans la direction de la caméra
	if Input.is_action_pressed("recule"):
		if Input.is_action_pressed("cours"):
				speed = 5.0
				#print("court")
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
	if niveau_batterie == 0:
		elec = false

func _on_timer_timeout():
	niveau_batterie = niveau_batterie -1
	$Timer.start()


func _on_timer_2_timeout():
	current_label.visible = false
	current_label = null




func _on_audio_stream_player_finished():
	if is_moving:
		$AudioStreamPlayer.play()

