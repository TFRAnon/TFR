extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Load.pressed.connect(buttonPressed.bind("Load"))
	$ReadMe.pressed.connect(buttonPressed.bind("ReadMe"))
	$Skip.pressed.connect(buttonPressed.bind("Skip"))
	$Auto.pressed.connect(buttonPressed.bind("Auto"))
	$Log.pressed.connect(buttonPressed.bind("Log"))
	$Config.pressed.connect(buttonPressed.bind("Config"))
	$Title.pressed.connect(buttonPressed.bind("Title"))
	$Close.pressed.connect(buttonPressed.bind("Close"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func buttonPressed(buttonName):
	match buttonName:
		"Load":
			# sends to load menu, returns to original location
			Global.setSettings("InMenu",false)
			Global.changeScene("LoadGame")
		"ReadMe":
			# sends to read me, returns to original location
			Global.setSettings("InMenu",false)
			Global.changeScene("ReadMe")
		"Skip":
			# sets text to auto skip
			pass
		"Auto":
			# sets text to auto scroll?
			pass
		"Log":
			# fade in overlay with log. return fades back
			pass
		"Config":
			Global.setSettings("InMenu",false)
			Global.changeScene("Config")
		"Title":
			# create confirm menu
			# sends to title, no save. 
			Global.setSettings("InMenu",true)
			Global.changeScene("MainMenu")
		"Close":
			# turns overlay visibility off.
			pass
