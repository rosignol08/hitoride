extends Node3D

var apparaition = 0
var mechant_scene = load("res://mechant_foret.tscn")
var mechant_instance: Node3D = null  # Référence à l'instance du méchant
var can_generate = true  # Contrôle si on peut générer un nouveau nombre
var esperence_de_vie = true

# Appelé lorsque le nœud entre dans l'arbre de la scène pour la première fois.
func _ready():
	$CharacterBody3D/Camera3D2.far = 20
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.volume_db = 0.0
	# Charger la scène de l'arbre
	var tree_scene = load("res://bambooo_bien.tscn")
	
	var bush_scene = load("res://objet_3d/dehors/arbre/bush/buisson.fbx")
	
	var bush2_scene = load("res://objet_3d/dehors/arbre/bush2/buisson2.fbx")
	
	var lanternes = load("res://lumiere_lanterne.tscn")
	
	# Ajouter 5000 arbres avec des positions et rotations aléatoires
	for i in range(5000):
		# Instancier l'arbre
		var tree_instance = tree_scene.instantiate()
		# Générer des coordonnées aléatoires
		var random_x = randf_range(-125, 125)
		var random_y = randf_range(-3, 0)
		var random_z = randf_range(-125, 125)
		
		# Définir la position de l'arbre
		tree_instance.transform.origin = Vector3(random_x, random_y, random_z)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		tree_instance.rotate_y(random_rotation_y)
		tree_instance.scale = Vector3(0.8,0.8,0.8)
		
		# Ajouter l'arbre à la scène actuelle
		add_child(tree_instance)
	#pour les buisson1
	for i in range(1000):
		# Instancier l'arbre
		var bush_instance = bush_scene.instantiate()
		# Générer des coordonnées aléatoires
		var random_x2 = randf_range(-125, 125)
		#var random_y2 = randf_range(0, 0)
		var random_z2 = randf_range(-125, 125)
		
		# Définir la position du buisson
		bush_instance.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		bush_instance.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(bush_instance)
	#pour les buisson2
	for i in range(1000):
		# Instancier l'arbre
		var bush_instance2 = bush2_scene.instantiate()
		
		# Générer des coordonnées aléatoires
		var random_x2 = randf_range(-125, 125)
		#var random_y2 = randf_range(0, 0)
		var random_z2 = randf_range(-125, 125)
		
		# Définir la position du buisson
		bush_instance2.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		bush_instance2.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(bush_instance2)
	for i in range(100):
		# Instancier l'arbre
		var lanternes_instance = lanternes.instantiate()
		
		# Générer des coordonnées aléatoires
		var random_x2 = randf_range(-125, 125)
		#var random_y2 = randf_range(0, 0)
		var random_z2 = randf_range(-125, 125)
		
		# Définir la position du buisson
		lanternes_instance.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		lanternes_instance.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(lanternes_instance)

# Appelé à chaque frame. 'delta' est le temps écoulé depuis la frame précédente.
func _process(_delta):
	#if Input.is_action_just_pressed("ui_up"):
	#	$CharacterBody3D2.active = true
	#	print("activé")
	#if Input.is_action_just_pressed("ui_down"):
	#	$CharacterBody3D2.active = false
	#	print("désactivé")
	#print("le volume est:", $AudioStreamPlayer.volume_db)
	if can_generate:
		if mechant_instance == null:
			# Générer un nombre aléatoire
			apparaition = randi()
			# Vérifier si le nombre est un multiple de 7
			if apparaition % 7 == 0:
				# Instancier la scène du méchant
				mechant_instance = mechant_scene.instantiate()
			
				# Récupérer la position du joueur
				var player_position = $CharacterBody3D.global_transform.origin
			
				# Générer une position aléatoire pour le méchant jusqu'à ce qu'elle soit à plus de 10 unités du joueur
				var random_offset_x
				var random_offset_z
				var mechant_position
				var distance_to_player = 0
				# Boucle jusqu'à trouver une position à plus de 10 unités du joueur
				while distance_to_player < 10:
					random_offset_x = randf_range(-30, 30)
					random_offset_z = randf_range(-30, 30)
					mechant_position = player_position + Vector3(random_offset_x, 0, random_offset_z)
					distance_to_player = player_position.distance_to(mechant_position)
			
				# Définir la position du méchant
				mechant_instance.transform.origin = player_position + Vector3(random_offset_x, 0, random_offset_z)
			
				# Ajouter le méchant à la scène
				add_child(mechant_instance)
				$Timer2.start()
				#on baisse le volume
	else:
		if mechant_instance != null:
			# Vérifier la distance entre le joueur et le méchant
			var player_position = $CharacterBody3D.global_transform.origin
			var mechant_position = mechant_instance.global_transform.origin
			
			# Calculer la distance entre le joueur et le méchant
			var distance = player_position.distance_to(mechant_position)
			
			# Si la distance est inférieure à 10 unités, supprimer le méchant
			if distance < 10:
				mechant_instance.queue_free()
				mechant_instance = null  # Réinitialiser la référence pour permettre la recréation
				# Arrêter la génération et démarrer le Timer
				can_generate = false
				$Timer.start()
				$AudioStreamPlayer.volume_db = 0.0
		else:
			$AudioStreamPlayer.volume_db = 0.0

# Fonction appelée lorsque le Timer expire (après 6 secondes)
func _on_timer_timeout():
	can_generate = true  # Réactiver la génération des nombres

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_timer_2_timeout():
	if mechant_instance != null: 
		mechant_instance.queue_free()
		mechant_instance = null  # Réinitialiser la référence pour permettre la recréation
		# Arrêter la génération et démarrer le Timer
		can_generate = false
		$Timer.start()

func _on_area_3d_body_entered(_body):
	Globale.numero_scene = 2  # Mets ici le numéro de la prochaine scène
	get_tree().call_deferred("change_scene_to_file", "res://ecrant_transition.tscn")


func _on_area_3d_2_body_entered(_body):
	preload("res://ecrant_transition.tscn")
