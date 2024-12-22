extends Control

var cligniote = 0
var addeur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cligniote = cos(addeur)
	addeur += 0.025
	#print(cligniote)
	if cligniote < 0:
		$Sprite2D.hide()
	else:
		$Sprite2D.show()
