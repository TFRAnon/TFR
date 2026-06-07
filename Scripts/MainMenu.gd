extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# connect all buttons
	$HBoxContainer/VBoxContainer/Start.pressed.connect(buttonPressed.bind("newgame"))
	$HBoxContainer/VBoxContainer/Config.pressed.connect(buttonPressed.bind("config"))
	$HBoxContainer/VBoxContainer/UpdateHistory.pressed.connect(buttonPressed.bind("updatehistory"))
	$HBoxContainer/VBoxContainer/ApplyPatch.pressed.connect(buttonPressed.bind("applypatch")) # will most likely be changed over to editor after release
	
	$HBoxContainer/VBoxContainer2/Continue.pressed.connect(buttonPressed.bind("continue"))
	$HBoxContainer/VBoxContainer2/Readme.pressed.connect(buttonPressed.bind("readme"))
	$HBoxContainer/VBoxContainer2/Credit.pressed.connect(buttonPressed.bind("credit"))
	$HBoxContainer/VBoxContainer2/Quit.pressed.connect(buttonPressed.bind("quit"))
	$FullScreen.pressed.connect(Global.toggleFullScreen)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# switch for all buttons in scene
func buttonPressed(button):
	match button:
		"newgame":
			pass
		"config":
			Global.changeScene("Config")
		"updatehistory":
			Global.changeScene("UpdateHistory")
		"applypatch":
			pass
		"continue":
			Global.changeScene("LoadGame")
		"readme":
			Global.changeScene("ReadMe")
		"credit":
			Global.changeScene("Credit")
		"quit":
			print("quitting")
			get_tree().quit()
