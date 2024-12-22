extends Node3D

@onready var player = null  # La référence du joueur
var prenable = false

# Appelé quand le nœud entre dans l'arbre de la scène pour la première fois.
func _ready():
	$Label3D.hide()
	# Obtenir une référence à l'instance du joueur dans la scène
	player = get_parent().get_node("CharacterBody3D")  # Assurez-vous que "perso" est le nom correct du nœud dans la scène



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if prenable:
		if Input.is_action_just_pressed("E"):
			player.bougie = true
			queue_free()


func _on_area_3d_area_entered(_area):
	$Label3D.show()
	prenable = true


func _on_area_3d_area_exited(_area):
	$Label3D.hide()
	prenable = false
