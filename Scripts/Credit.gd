extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureButton.pressed.connect(buttonPressed)


func buttonPressed():
	Global.changeScene("MainMenu")
