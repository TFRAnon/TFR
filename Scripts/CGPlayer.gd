extends Node2D

var data : Array
var sceneNumber : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Next.pressed.connect(buttonPressed.bind("Next"))
	$Previous.pressed.connect(buttonPressed.bind("Previous"))
	$InternalToggle.pressed.connect(buttonPressed.bind("InternalToggle"))
	$DialogueToggle.pressed.connect(buttonPressed.bind("DialogueToggle"))
	$SFXToggle.pressed.connect(buttonPressed.bind("SFXToggle"))
	$EffectsToggle.pressed.connect(buttonPressed.bind("EffectsToggle"))
	$ReturnToMemory.pressed.connect(buttonPressed.bind("ReturnToMemory"))
	sceneNumber = 0
	clearScene()
	loadData()
	loadScene()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func buttonPressed(buttonName):
	match buttonName:
		"InternalToggle":
			$Internal.visible = !$Internal.visible
		"DialogueToggle":
			$Dialogue.visible = !$Dialogue.visible
		"SFXToggle":
			$SFX.visible = !$SFX.visible
		"EffectsToggle":
			$Effects.visible = !$Effects.visible
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

func loadScene():
	var imageQueue = data[sceneNumber]
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

func has_position(array: Array, position: int) -> bool:
	return position >= 0 and position < array.size()
