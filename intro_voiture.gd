extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CharacterBody3D/Camera3D2.far = 40
	# Charger la scène de l'arbre
	var tree_scene = load("res://bambooo_bien.tscn")
	
	var bush_scene = load("res://objet_3d/dehors/arbre/bush/buisson.fbx")
	
	var bush2_scene = load("res://objet_3d/dehors/arbre/bush2/buisson2.fbx")
	
	#5,15 -3,15 -3,-22 5,-22
	# Ajouter 10000 arbres avec des positions et rotations aléatoires
	for i in range(1000):
		# Instancier l'arbre
		var tree_instance = tree_scene.instantiate()
		# Générer des coordonnées aléatoires
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x
		var random_y
		var random_z
		while true:
			random_x = randf_range(-130, 130)
			random_y = 0#randf_range(0, 0.7)
			random_z = randf_range(-130, 140)
			
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x > -3 and random_x < 5 and random_z > -22 and random_z < 15):
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
	for i in range(500):
		# Instancier l'arbre
		var bush_instance = bush_scene.instantiate()
		
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x2
		var random_z2
		while true:
			random_x2 = randf_range(-130, 130)
			random_z2 = randf_range(-130, 140)
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x2 > -3 and random_x2 < 5 and random_z2 > -22 and random_z2 < 15):
				break  # Sortir de la boucle si les coordonnées sont valides
		
		# Définir la position du buisson
		bush_instance.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		bush_instance.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(bush_instance)
	#pour les buisson2
	for i in range(500):
		# Instancier l'arbre
		var bush_instance2 = bush2_scene.instantiate()
		
		# Boucle tant que les coordonnées sont dans la zone interdite
		var random_x2
		var random_z2
		while true:
			random_x2 = randf_range(-130, 130)
			random_z2 = randf_range(-130, 140)
			# Vérifier si les coordonnées sont dans la zone interdite
			if not (random_x2 > -3 and random_x2 < 5 and random_z2 > -22 and random_z2 < 15):
				break  # Sortir de la boucle si les coordonnées sont valides
		
		# Définir la position du buisson
		bush_instance2.transform.origin = Vector3(random_x2, 0, random_z2)
		
		# Générer une rotation aléatoire sur l'axe Y
		var random_rotation_y = randf_range(0, TAU)
		bush_instance2.rotate_y(random_rotation_y)
		
		# Ajouter le buisson à la scène actuelle
		add_child(bush_instance2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta_):
	pass


func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Globale.numero_scene = 1
	get_tree().call_deferred("change_scene_to_file", "res://ecrant_transition.tscn")
