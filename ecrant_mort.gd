extends Control

# Tableau contenant les citations
var citations = ["Si tu plonges longtemps ton regard dans l abime, \nl abime te regarde aussi.\n-Friedrich Nietzsche","Le plus effrayant n est pas que les tenebres nous engloutissent, \nmais que nous ayons peur de la lumiere.\n-Platon","Le mal n est pas quelque chose que l on fait, \nc est quelque chose que l on est.\n-Albert Camus","Les monstres sont reels, et ils vivent parmi nous. Et parfois, ils sont nous.\n-Stephen King"]

@onready var citation_label = $CanvasLayer2/Label # Assure-toi que le chemin est correct vers ton label

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	# Choisir une citation aléatoire
	var citation_aleatoire = citations[randi() % citations.size()]
	# Afficher la citation dans le Label
	citation_label.text = citation_aleatoire

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("R"):
		# Choisir une citation aléatoire
		var citation_aleatoire = citations[randi() % citations.size()]
		# Afficher la citation dans le Label
		citation_label.text = citation_aleatoire
func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
