extends Node2D

var currentlySelected : String
var textureChanged : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/VBoxContainer/SilverGlass.pressed.connect(buttonPressed.bind("SilverGlass"))
	$HBoxContainer/VBoxContainer/IvoryFiber.pressed.connect(buttonPressed.bind("IvoryFiber"))
	$HBoxContainer/VBoxContainer/JellyHoney.pressed.connect(buttonPressed.bind("JellyHoney"))
	$HBoxContainer/VBoxContainer/ApricotSmile.pressed.connect(buttonPressed.bind("ApricotSmile"))
	$HBoxContainer/VBoxContainer/OchreBreeze.pressed.connect(buttonPressed.bind("OchreBreeze"))
	$HBoxContainer/VBoxContainer/SmoothTurquoise.pressed.connect(buttonPressed.bind("SmoothTurquoise"))
	$HBoxContainer/VBoxContainer/AquamarineTermerature.pressed.connect(buttonPressed.bind("AquamarineTermerature"))
	$HBoxContainer/VBoxContainer/MagentaTouch.pressed.connect(buttonPressed.bind("MagentaTouch"))
	
	$HBoxContainer/VBoxContainer2/RustyGainsboro.pressed.connect(buttonPressed.bind("RustyGainsboro"))
	$HBoxContainer/VBoxContainer2/LimeSwing.pressed.connect(buttonPressed.bind("LimeSwing"))
	$HBoxContainer/VBoxContainer2/BrilliantRed.pressed.connect(buttonPressed.bind("BrilliantRed"))
	$HBoxContainer/VBoxContainer2/MistyRose.pressed.connect(buttonPressed.bind("MistyRose"))
	$HBoxContainer/VBoxContainer2/CinnamonFlavor.pressed.connect(buttonPressed.bind("CinnamonFlavor"))
	$HBoxContainer/VBoxContainer2/IndigoIllumination.pressed.connect(buttonPressed.bind("IndigoIllumination"))
	$HBoxContainer/VBoxContainer2/DeepScarlet.pressed.connect(buttonPressed.bind("DeepScarlet"))
	
	$SetAsIndoorBGM.pressed.connect(setCurrentBGM)
	$Back.pressed.connect(returnHome)
	buttonPressed(Global.getGameData("HomeBGM"))
	$CurrentIndoorBGM.text = splitCamelCase(currentlySelected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	processBackground()

func buttonPressed(button):
	enableAllButtons()
	textureChanged = true
	match button:
		"SilverGlass":
			changeBackground("res://Textures/Music/room.jpg")
			$HBoxContainer/VBoxContainer/SilverGlass.disabled = true
			currentlySelected = "SilverGlass"
		"IvoryFiber":
			changeBackground("res://Textures/Music/door_n.jpg")
			$HBoxContainer/VBoxContainer/IvoryFiber.disabled = true
			currentlySelected = "IvoryFiber"
		"JellyHoney":
			changeBackground("res://Textures/Music/sweets.jpg")
			$HBoxContainer/VBoxContainer/JellyHoney.disabled = true
			currentlySelected = "JellyHoney"
		"ApricotSmile":
			changeBackground("res://Textures/Music/market.jpg")
			$HBoxContainer/VBoxContainer/ApricotSmile.disabled = true
			currentlySelected = "ApricotSmile"
		"OchreBreeze":
			changeBackground("res://Textures/Music/town.jpg")
			$HBoxContainer/VBoxContainer/OchreBreeze.disabled = true
			currentlySelected = "OchreBreeze"
		"SmoothTurquoise":
			changeBackground("res://Textures/Music/town.jpg")
			$HBoxContainer/VBoxContainer/SmoothTurquoise.disabled = true
			currentlySelected = "SmoothTurquoise"
		"AquamarineTermerature":
			changeBackground("res://Textures/Music/forest.jpg")
			$HBoxContainer/VBoxContainer/AquamarineTermerature.disabled = true
			currentlySelected = "AquamarineTermerature"
		"MagentaTouch":
			changeBackground("res://Textures/Music/bed.jpg")
			$HBoxContainer/VBoxContainer/MagentaTouch.disabled = true
			currentlySelected = "MagentaTouch"
		"RustyGainsboro":
			changeBackground("res://Textures/Music/market.jpg")
			$HBoxContainer/VBoxContainer2/RustyGainsboro.disabled = true
			currentlySelected = "RustyGainsboro"
		"LimeSwing":
			changeBackground("res://Textures/Music/cafe.jpg")
			$HBoxContainer/VBoxContainer2/LimeSwing.disabled = true
			currentlySelected = "LimeSwing"
		"BrilliantRed":
			changeBackground("res://Textures/Music/d_shop.jpg")
			$HBoxContainer/VBoxContainer2/BrilliantRed.disabled = true
			currentlySelected = "BrilliantRed"
		"MistyRose":
			changeBackground("res://Textures/Music/work.jpg")
			$HBoxContainer/VBoxContainer2/MistyRose.disabled = true
			currentlySelected = "MistyRose"
		"CinnamonFlavor":
			changeBackground("res://Textures/Music/tea.jpg")
			$HBoxContainer/VBoxContainer2/CinnamonFlavor.disabled = true
			currentlySelected = "CinnamonFlavor"
		"IndigoIllumination":
			changeBackground("res://Textures/Music/restaurant.jpg")
			$HBoxContainer/VBoxContainer2/IndigoIllumination.disabled = true
			currentlySelected = "IndigoIllumination"
		"DeepScarlet":
			changeBackground("res://Textures/Music/d_shop_n.jpg")
			$HBoxContainer/VBoxContainer2/DeepScarlet.disabled = true
			currentlySelected = "DeepScarlet"

func enableAllButtons():
	for node in $HBoxContainer/VBoxContainer.get_children():
		node.disabled = false
	for node in $HBoxContainer/VBoxContainer2.get_children():
		node.disabled = false

func changeBackground(path):
	$Background2.texture = $Background.texture
	$Background2.self_modulate.a = 1
	$Background.texture = load(path)
	textureChanged = true

func processBackground():
	if textureChanged:
		$Background2.self_modulate.a = lerp($Background2.self_modulate.a, 0.0, 0.1)
		if $Background2.self_modulate.a <= 0.1:
			$Background2.self_modulate.a = 0
			textureChanged = false

func setCurrentBGM():
	$CurrentIndoorBGM.text = splitCamelCase(currentlySelected)
	Global.setGameData("HomeBGM",currentlySelected)

func returnHome():
	Global.changeScene("Home")

func splitCamelCase(text: String) -> String:
	var result := ""

	for c in text:
		if c == c.to_upper() and c != c.to_lower():
			result += " "
		result += c

	return result.strip_edges()
