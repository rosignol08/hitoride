extends CharacterBody3D

# Variables à ajuster
#var player : Node = null  # Assigner la référence du joueur ici
#var animation_player : AnimationPlayer = null  # Assigner le noeud AnimationPlayer
var speed : float = 2.0  # Vitesse de déplacement
var gravite : float = 9.8 #gravite

@onready var player =  $"../CharacterBody3D" #le chemin du joueur
@onready var animation_player = $"Root Scene/AnimationPlayer"  # Assigne ton AnimationPlayer ici
@onready var nav_agent = $NavigationAgent3D
@onready var active = false
var est_visible = true
var commence_jouer = false

# Fonction pour mettre à jour la position cible du NavigationAgent
func update_targert_location(target_location :Vector3):
	nav_agent.target_position = target_location

func move_to(target_position: Vector3):
	var direction = (target_position - global_transform.origin).normalized()
	# Garder la position 'y' égale à celle du joueur
	var new_position = global_transform.origin
	#new_position.y = target_position.y-1  # Ajuster uniquement la coordonnée Y pour égaler celle du joueur
	# Appliquer le mouvement uniquement sur les axes X et Z, mais avec la même hauteur (Y)
	global_transform.origin = new_position + direction * speed
	# Orienter le personnage vers le joueur
	look_at(target_position, Vector3(0,1,0))
	rotation.x = 0
	rotation.z = 0

# Fonction pour gérer les déplacements en utilisant move_and_slide()
func move_with_navigation(delta, target_position: Vector3):
	# Gestion de la gravité
	if not is_on_floor():
		velocity.y -= gravite * delta  # Appliquer la gravité si pas au sol
	else:
		velocity.y = 0  # Réinitialiser la gravité si on est au sol
	# Calcul du chemin vers la prochaine position du NavigationAgent
	#var next_location = nav_agent.get_next_path_position()
	#var current_location = global_transform.origin
	# Calcul de la direction et de la nouvelle vitesse horizontale
	#var direction = (next_location - current_location).normalized()
	var direction = (target_position - global_transform.origin).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Appliquer la vélocité avec move_and_slide(), y compris la gravité
	move_and_slide()
	# Orienter le personnage vers la prochaine position, pas juste la direction
	look_at(target_position, Vector3(0,1,0))
	rotation.x = 0  # Garder l'axe X neutre
	rotation.z = 0  # Garder l'axe Z neutre

func joue_musique():
	if commence_jouer == false:
		commence_jouer = true
		$AudioStreamPlayer3D.play()


func _ready():
	$AudioStreamPlayer3D.stop()

func _process(delta):
	if active == false:
		if not is_on_floor():
			velocity.y -= gravite * delta  # Appliquer la gravité si pas au sol
			move_and_slide()
		animation_player.play("idlee")  # Joue l'animation "assit"
	# Mise à jour du mouvement et pathfinding si le personnage est invisible
	if est_visible == false:
		move_with_navigation(delta,player.global_transform.origin)
		animation_player.play("avancee")  # Joue l'animation "avancee"
		

func _on_visible_on_screen_notifier_3d_screen_entered():
	if active == true:
		est_visible = true
		animation_player.pause()  # Met l'animation en pause
		$AudioStreamPlayer3D.volume_db = -50.0


func _on_visible_on_screen_notifier_3d_screen_exited():
	if active == true:
		est_visible = false
		$AudioStreamPlayer3D.volume_db = -10.0
		joue_musique()
		#if $"Root Scene".position.y - player.position.y < 1:
		


func _on_audio_stream_player_3d_finished():
	$AudioStreamPlayer3D.play()
