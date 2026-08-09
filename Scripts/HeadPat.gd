extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuBackground/Continue.pressed.connect(buttonPressed.bind("Continue"))
	$MenuBackground/Stop.pressed.connect(buttonPressed.bind("Stop"))
	$MenuBackground/Repeat.pressed.connect(buttonPressed.bind("Repeat"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func buttonPressed(buttonName):
	match buttonName:
		"Continue":
			pass
		"Stop":
			Global.changeScene("Home")
		"Repeat":
			pass
