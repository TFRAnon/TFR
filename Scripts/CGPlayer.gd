extends Node2D

var data : Array
var sceneNumber : int
var currentText : Array
var textPos : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CGMode/Next.pressed.connect(buttonPressed.bind("Next"))
	$CGMode/Previous.pressed.connect(buttonPressed.bind("Previous"))
	$CGMode/InternalToggle.pressed.connect(buttonPressed.bind("InternalToggle"))
	$CGMode/DialogueToggle.pressed.connect(buttonPressed.bind("DialogueToggle"))
	$CGMode/SFXToggle.pressed.connect(buttonPressed.bind("SFXToggle"))
	$CGMode/EffectsToggle.pressed.connect(buttonPressed.bind("EffectsToggle"))
	$CGMode/ReturnToMemory.pressed.connect(buttonPressed.bind("ReturnToMemory"))
	
	$SceneMode/EffectsToggle.pressed.connect(buttonPressed.bind("EffectsToggle"))
	$SceneMode/DialogueToggle.pressed.connect(buttonPressed.bind("DialogueToggle"))
	$SceneMode/SFXToggle.pressed.connect(buttonPressed.bind("SFXToggle"))
	$SceneMode/InternalToggle.pressed.connect(buttonPressed.bind("InternalToggle"))
	$SceneMode/ReturnToMemory.pressed.connect(buttonPressed.bind("ReturnToMemory"))
	
	$SceneMode/Load.pressed.connect(openLoadMenu)
	$SceneMode/SkipToggle.pressed.connect(toggleSkip)
	$SceneMode/AutoToggle.pressed.connect(toggleAuto)
	$SceneMode/Log.pressed.connect(openLog)
	$SceneMode/TextBoxClicked.pressed.connect(continueText)
	$SceneMode/CloseUI.pressed.connect(closeUI)
	
	$ReopenUI.pressed.connect(openUI)
	
	if Global.getGameData("CGMode"):
		$CGMode.visible = true
		$SceneMode.visible = false
	else:
		$CGMode.visible = false
		$SceneMode.visible = true
	
	sceneNumber = 0
	textPos = 0
	clearScene()
	loadData()
	loadScene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	processText(delta)

func buttonPressed(buttonName):
	match buttonName:
		"InternalToggle":
			$Internal.visible = !$Internal.visible
			if $Internal.visible:
				$CGMode/InternalToggle.texture_normal = load("res://Textures/CGPlayer/se-.png")
				$CGMode/InternalToggle.texture_hover = null
				$SceneMode/InternalToggle.texture_normal = load("res://Textures/CGPlayer/se-.png")
				$SceneMode/InternalToggle.texture_hover = null
			else:
				$CGMode/InternalToggle.texture_normal = load("res://Textures/CGPlayer/se.png")
				$CGMode/InternalToggle.texture_hover = load("res://Textures/CGPlayer/se_.png")
				$SceneMode/InternalToggle.texture_normal = load("res://Textures/CGPlayer/se.png")
				$SceneMode/InternalToggle.texture_hover = load("res://Textures/CGPlayer/se_.png")
		"DialogueToggle":
			$Dialogue.visible = !$Dialogue.visible
			if $Dialogue.visible:
				$CGMode/DialogueToggle.texture_normal = load("res://Textures/CGPlayer/tx-.png")
				$CGMode/DialogueToggle.texture_hover = null
				$SceneMode/DialogueToggle.texture_normal = load("res://Textures/CGPlayer/tx-.png")
				$SceneMode/DialogueToggle.texture_hover = null
			else:
				$CGMode/DialogueToggle.texture_normal = load("res://Textures/CGPlayer/tx.png")
				$CGMode/DialogueToggle.texture_hover = load("res://Textures/CGPlayer/tx_.png")
				$SceneMode/DialogueToggle.texture_normal = load("res://Textures/CGPlayer/tx.png")
				$SceneMode/DialogueToggle.texture_hover = load("res://Textures/CGPlayer/tx_.png")
		"SFXToggle":
			$SFX.visible = !$SFX.visible
			if $SFX.visible:
				$CGMode/SFXToggle.texture_normal = load("res://Textures/CGPlayer/xr-.png")
				$CGMode/SFXToggle.texture_hover = null
				$SceneMode/SFXToggle.texture_normal = load("res://Textures/CGPlayer/xr-.png")
				$SceneMode/SFXToggle.texture_hover = null
			else:
				$CGMode/SFXToggle.texture_normal = load("res://Textures/CGPlayer/xr.png")
				$CGMode/SFXToggle.texture_hover = load("res://Textures/CGPlayer/xr_.png")
				$SceneMode/SFXToggle.texture_normal = load("res://Textures/CGPlayer/xr.png")
				$SceneMode/SFXToggle.texture_hover = load("res://Textures/CGPlayer/xr_.png")
		"EffectsToggle":
			$Effects.visible = !$Effects.visible
			if $Effects.visible:
				$CGMode/EffectsToggle.texture_normal = load("res://Textures/CGPlayer/ef-.png")
				$CGMode/EffectsToggle.texture_hover = null
				$SceneMode/EffectsToggle.texture_normal = load("res://Textures/CGPlayer/ef-.png")
				$SceneMode/EffectsToggle.texture_hover = null
			else:
				$CGMode/EffectsToggle.texture_normal = load("res://Textures/CGPlayer/ef.png")
				$CGMode/EffectsToggle.texture_hover = load("res://Textures/CGPlayer/ef_.png")
				$SceneMode/EffectsToggle.texture_normal = load("res://Textures/CGPlayer/ef.png")
				$SceneMode/EffectsToggle.texture_hover = load("res://Textures/CGPlayer/ef_.png")
		"ReturnToMemory":
			Global.changeScene("Memory")
		"Next":
			if has_position(data,sceneNumber+1):
				clearScene()
				sceneNumber += 1
				loadScene()
			else:
				print("at end")
		"Previous":
			if has_position(data,sceneNumber-1):
				clearScene()
				sceneNumber -= 1
				loadScene()
			else:
				print("at start")

func loadData():
	data = Global.getMemoryData(Global.getGameData("CurrentMemory"))

func clearScene():
	for node in $Background.get_children():
		node.queue_free()
	for node in $Effects.get_children():
		node.queue_free()
	for node in $SFX.get_children():
		node.queue_free()
	for node in $Main.get_children():
		node.queue_free()
	for node in $Internal.get_children():
		node.queue_free()
	for node in $Dialogue.get_children():
		node.queue_free()
	for node in $HairFront.get_children():
		node.queue_free()
	for node in $HairBack.get_children():
		node.queue_free()

func loadScene():
	var imageQueue = data[sceneNumber]
	
	# set text
	currentText = imageQueue["Text"]
	continueText()
	
	# set images
	for imgTexture in imageQueue["Background"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$Background.add_child(newImage)
	for imgTexture in imageQueue["Effects"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$Effects.add_child(newImage)
	for imgTexture in imageQueue["SFX"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$SFX.add_child(newImage)
	for imgTexture in imageQueue["Main"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$Main.add_child(newImage)
	for imgTexture in imageQueue["Internal"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$Internal.add_child(newImage)
	for imgTexture in imageQueue["SpeachBubbles"]:
		var newImage := Sprite2D.new()
		newImage.position = Vector2(960, 540)
		newImage.scale = Vector2(1.2, 1.2)
		newImage.texture = load(imgTexture)
		$Dialogue.add_child(newImage)
	if !imageQueue["Hair"].is_empty():
		for imgTexture in imageQueue["Hair"][0]:
			var newImage := Sprite2D.new()
			newImage.position = Vector2(960, 540)
			newImage.scale = Vector2(1.2, 1.2)
			newImage.texture = load(imgTexture)
			$HairFront.add_child(newImage)
		for imgTexture in imageQueue["Hair"][1]:
			var newImage := Sprite2D.new()
			newImage.position = Vector2(960, 540)
			newImage.scale = Vector2(1.2, 1.2)
			newImage.texture = load(imgTexture)
			$HairBack.add_child(newImage)

func has_position(array: Array, position: int) -> bool:
	return position >= 0 and position < array.size()

func continueText():
	# when all text is used up
	if currentText.is_empty():
		$SceneMode/MainText.text = ""
		textPos = 0
		$SceneMode/MainText.visible_characters = 0
		buttonPressed("Next")
		return
	
	# If text is still scrolling, finish displaying it
	if textPos < $SceneMode/MainText.text.length():
		textPos = $SceneMode/MainText.text.length()
		$SceneMode/MainText.visible_characters = $SceneMode/MainText.text.length()
		return
	
	# reset text if text block is finished
	if currentText[0].is_empty():
		currentText.pop_front()
		$SceneMode/MainText.text = ""
		textPos = 0
		$SceneMode/MainText.visible_characters = 0
		# If no more text blocks remain
		if currentText.is_empty():
			buttonPressed("Next")
			return
		$SceneMode/MainText.text = currentText[0].pop_front()
	else:
		var next_text = currentText[0].pop_front()
		if $SceneMode/MainText.text == "":
			$SceneMode/MainText.text = next_text
			textPos = 0
			$SceneMode/MainText.visible_characters = 0
		else:
			textPos = $SceneMode/MainText.text.length()
			$SceneMode/MainText.visible_characters = $SceneMode/MainText.text.length()
			$SceneMode/MainText.text += next_text
	
	# Apply tags inside text
	checkTextTags()

func checkTextTags():
	var startPos = $SceneMode/MainText.text.find("#")
	if startPos == -1:
		return

	var endPos = $SceneMode/MainText.text.find("#", startPos + 1)
	if endPos == -1:
		return

	var tagText = $SceneMode/MainText.text.substr(startPos + 1, endPos - startPos - 1)
	setNameTag(tagText)
	
	$SceneMode/MainText.text = $SceneMode/MainText.text.substr(0, startPos) + $SceneMode/MainText.text.substr(endPos + 1)

func openLoadMenu():
	pass

func openLog():
	pass

func toggleSkip():
	pass

func toggleAuto():
	pass

func setNameTag(newName):
	$SceneMode/HEventNamePlate/NameTag.text = newName
	if newName == "":
		$SceneMode/HEventNamePlate.visible = false
	else:
		$SceneMode/HEventNamePlate.visible = true

func closeUI():
	$CGMode.visible = false
	$SceneMode.visible = false
	$ReopenUI.visible = true

func openUI():
	$ReopenUI.visible = false
	if Global.getGameData("CGMode"):
		$CGMode.visible = true
	else:
		$SceneMode.visible = true

func processText(delta):
	textPos += delta * Global.getSettings("ScrollSpeed")
	$SceneMode/MainText.visible_characters = textPos
