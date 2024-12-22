extends Node3D
@onready var joueur = $CharacterBody3D
var points_a_recuperer = 1
var se_ferme = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Globale.masque_ramasse = points_a_recuperer
	$CharacterBody3D/Camera3D2.far = 20
	# Charger la scène de l'arbre
	var tree_scene = load("res://bambooo_bien.tscn")
	
	var bush_scene = load("res://objet_3d/dehors/arbre/bush/buisson.fbx")
	
	var bush2_scene = load("res://objet_3d/dehors/arbre/bush2/buisson2.fbx")
	
	
	# Ajouter 10000 arbres avec des positions et rotations aléatoires
	for i in range(4000):
		# Instancier l'arbre
		var tree_instance = tree_scene.instantiate()
		# Générer des coordonnées aléatoires
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x
		var random_y
		var random_z
		while true:
			random_x = randf_range(-130, 130)
			random_y = randf_range(-3, 0)
			random_z = randf_range(-130, 140)
			
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x > -15 and random_x < 17 and random_z > -18 and random_z < 15):
				break  # Sortir de la boucle si les coordonnées sont valides
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
		
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x2
		var random_z2
		while true:
			random_x2 = randf_range(-130, 130)
			random_z2 = randf_range(-130, 140)
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x2 > -15 and random_x2 < 17 and random_z2 > -18 and random_z2 < 15):
				break  # Sortir de la boucle si les coordonnées sont valides
		
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
		
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x2
		var random_z2
		while true:
			random_x2 = randf_range(-130, 130)
			random_z2 = randf_range(-130, 140)
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x2 > -15 and random_x2 < 17 and random_z2 > -18 and random_z2 < 15):
				break  # Sortir de la boucle si les coordonnées sont valides
		
		# Définir la position du buisson
		bush_instance2.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		bush_instance2.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(bush_instance2)
		#$CharacterBody3D.active = false
		#$CharacterBody3D/Camera3D2.set_current(false)
		#$Camera3D.set_current(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	points_a_recuperer = Globale.masque_ramasse
	get_tree().call_group("mane_anime","update_targert_location",joueur.global_transform.origin)
	#print($CharacterBody3D2.position)
	$CharacterBody3D2.active = Globale.activer
	if $CharacterBody3D2.position.distance_to($CharacterBody3D.position) <= 1.5:
		get_tree().call_deferred("change_scene_to_file", "res://ecrant_mort.tscn")
	if $CharacterBody3D.position.x > -11.6 and points_a_recuperer != 0 and se_ferme == false:
		$StaticBody3D/Node3D12.activee = false 
		$StaticBody3D/Node3D13.activee = false
		$StaticBody3D/Node3D14.activee = false
		$StaticBody3D/Node3D15.activee = false
		$StaticBody3D/Node3D12.seferme = true 
		$StaticBody3D/Node3D13.seferme = true
		$StaticBody3D/Node3D14.seferme = true
		$StaticBody3D/Node3D15.seferme = true
		se_ferme = true
	if points_a_recuperer == 0:
		$StaticBody3D/Node3D12.activee = true 
		$StaticBody3D/Node3D13.activee = true
		$StaticBody3D/Node3D14.activee = true
		$StaticBody3D/Node3D15.activee = true
		$StaticBody3D/Node3D12.seferme = false
		$StaticBody3D/Node3D13.seferme = false
		$StaticBody3D/Node3D14.seferme = false
		$StaticBody3D/Node3D15.seferme = false
