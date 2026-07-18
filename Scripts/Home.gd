extends Node2D

var timeWhenLastUpdated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Buttons/PatHead.pressed.connect(buttonPressed.bind("PatHead"))
	$Buttons/Chat.pressed.connect(buttonPressed.bind("Chat"))
	$Buttons/Molest.pressed.connect(buttonPressed.bind("Molest"))
	$Buttons/Items.pressed.connect(buttonPressed.bind("Items"))
	$Buttons/Status.pressed.connect(buttonPressed.bind("Status"))
	$Buttons/Save.pressed.connect(buttonPressed.bind("Save"))
	$Buttons/Memory.pressed.connect(buttonPressed.bind("Memory"))
	$Buttons/Repeat.pressed.connect(toggleRepeat)
	timeWhenLastUpdated = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	keepUpdated()

func buttonPressed(buttonName):
	print(buttonName+" : pressed")
	match buttonName:
		"PatHead":
			pass

func toggleRepeat():
	if Global.getSettings("RepeatToggled"):
		Global.setSettings("RepeatToggled",false)
	else:
		Global.setSettings("RepeatToggled",true)

# yes this is inefficient as hell but I have processing power to spare and it keeps things simple
func keepUpdated():
	if timeWhenLastUpdated != Global.getSettings("CurrentTime"):
		updateTimeBackground()
	var onTexture = load("res://Textures/Home/buttons/repeat-.png")
	var offTexture = load("res://Textures/Home/buttons/repeat.png")
	if Global.getSettings("RepeatToggled"):
		$Buttons/Repeat.texture_normal = onTexture
		$Buttons/Repeat.texture_pressed = offTexture
	else:
		$Buttons/Repeat.texture_normal = offTexture
		$Buttons/Repeat.texture_pressed = onTexture

func updateTimeBackground():
	var texture
	match Global.getSettings("CurrentTime"):
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
