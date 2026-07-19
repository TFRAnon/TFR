extends Node2D

var timeWhenLastUpdated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HomeButtons/PatHead.pressed.connect(buttonPressed.bind("PatHead"))
	$HomeButtons/Chat.pressed.connect(buttonPressed.bind("Chat"))
	$HomeButtons/Molest.pressed.connect(buttonPressed.bind("Molest"))
	$HomeButtons/Items.pressed.connect(buttonPressed.bind("Items"))
	$HomeButtons/Status.pressed.connect(buttonPressed.bind("Status"))
	$HomeButtons/Save.pressed.connect(buttonPressed.bind("Save"))
	$HomeButtons/Memory.pressed.connect(buttonPressed.bind("Memory"))
	$HomeButtons/Repeat.pressed.connect(toggleRepeat)
	timeWhenLastUpdated = -1
	Global.resetInternalSceneData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	keepUpdated()

func buttonPressed(buttonName):
	print(buttonName+" : pressed")
	match buttonName:
		"Save":
			Global.setGameData("return",true)
			Global.changeScene("SaveGame")
		"PatHead":
			pass

func toggleRepeat():
	if Global.getSettings("RepeatToggled"):
		Global.setSettings("RepeatToggled",false)
	else:
		Global.setSettings("RepeatToggled",true)

# yes this is inefficient as hell but I have processing power to spare and it keeps things simple
func keepUpdated():
	if timeWhenLastUpdated != Global.getGameData("CurrentTime"):
		updateTimeBackground()
	var onTexture = load("res://Textures/Home/buttons/repeat-.png")
	var offTexture = load("res://Textures/Home/buttons/repeat.png")
	if Global.getSettings("RepeatToggled"):
		$HomeButtons/Repeat.texture_normal = onTexture
		$HomeButtons/Repeat.texture_pressed = offTexture
	else:
		$HomeButtons/Repeat.texture_normal = offTexture
		$HomeButtons/Repeat.texture_pressed = onTexture

func updateTimeBackground():
	var texture
	match Global.getGameData("CurrentTime"):
		0 :
			texture = load("res://Textures/Home/Time/1.png")
			$Time.texture = texture
		1 :
			texture = load("res://Textures/Home/Time/2.png")
			$Time.texture = texture
		2 : 
			texture = load("res://Textures/Home/Time/3.png")
			$Time.texture = texture
		3 : 
			texture = load("res://Textures/Home/Time/4.png")
			$Time.texture = texture
		4 : 
			texture = load("res://Textures/Home/Time/5.png")
			$Time.texture = texture
		5 : 
			texture = load("res://Textures/Home/Time/6.png")
			$Time.texture = texture
		6 :
			texture = load("res://Textures/Home/Time/7.png")
			$Time.texture = texture
