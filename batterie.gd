extends Node3D

@onready var player =  $"../CharacterBody3D" #le chemin du joueur

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_3d_area_entered(_area):
	player.ramasse = true
	queue_free()
