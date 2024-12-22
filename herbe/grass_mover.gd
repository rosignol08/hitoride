@tool
extends Node3D

var herbe = true

func check_for_multimesh_instance():
	var root_node = get_tree().root.get_child(0)  # Récupère le premier enfant de la scène principale
	return _check_node_for_multimesh(root_node)

func _check_node_for_multimesh(node):
	if node is MultiMeshInstance3D:
		return true  # Si un MultiMeshInstance3D est trouvé, retourne true
	for child in node.get_children():
		if _check_node_for_multimesh(child):
			return true  # Si un enfant contient un MultiMeshInstance3D, retourne true
	return false  # Aucun MultiMeshInstance3D trouvé


func _ready():
	# Trouve le nœud avec le nom "Grass" s'il existe
	var grass_node = check_for_multimesh_instance() #get_tree().root.get_node_or_null("Grass")
	# Vérifie s'il existe et si c'est bien un MultiMeshInstance
	if grass_node != null:
		print("Le nœud Grass existe et est de type MultiMeshInstance")
		herbe = true
	else:
		print("Le nœud Grass n'existe pas ou n'est pas de type MultiMeshInstance")
		herbe = false



# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if herbe:
		get_parent().get_parent().get_node("Grass").material_override.set_shader_parameter("player_pos", global_transform.origin)
	else:
		pass
