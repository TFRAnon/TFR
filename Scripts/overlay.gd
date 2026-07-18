extends Node2D

var logPageVisible
var confirmPageVisible
var textData : Array
var textPos
var timeSinceLastMove : float

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
	$TextButton.pressed.connect(buttonPressed.bind("TextPressed"))
	
	$LogPage/ExitButton.pressed.connect(closeLog)
	logPageVisible = false
	confirmPageVisible = false
	
	$ConfirmPage/Confirm/Cancel.pressed.connect(closeConfirm)
	
	Global.displayText.connect(displayNewText)
	Global.displayNameCard.connect(changeNamecard)
	Global.makeChoice.connect(createChoices)
	textData = [""]
	textPos = 0
	timeSinceLastMove = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if logPageVisible:
		$LogPage.modulate.a = lerp($LogPage.modulate.a, 1.0, 0.1)
	else:
		$LogPage.modulate.a = lerp($LogPage.modulate.a, 0.0, 0.1)
		if $LogPage.modulate.a <= 0.1:
			$LogPage.visible = false
	
	if confirmPageVisible:
		$ConfirmPage.modulate.a = lerp($ConfirmPage.modulate.a, 1.0, 0.1)
	else:
		$ConfirmPage.modulate.a = 0.0
		$ConfirmPage.visible = false
	processText(delta)
	if isSkiped():
		buttonPressed("TextPressed")
	if isAuto():
		timeSinceLastMove += delta
		if timeSinceLastMove > ( Global.getSettings("AutoScrollSpeed") / 4):
			timeSinceLastMove = 0
			buttonPressed("TextPressed")


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
			toggleSkip()
		"Auto":
			# sets text to auto scroll?
			toggleAuto()
		"Log":
			# fade in overlay with log. return fades back
			logPageVisible = true
			$LogPage.visible = true
		"Config":
			Global.setSettings("InMenu",false)
			Global.changeScene("Config")
		"Title":
			$ConfirmPage.visible = true
			# sends to title, no save. 
			openConfirmMenu("Return to the title screen. Okay?",goToMainMenu)
		"Close":
			# turns overlay visibility off.
			closeUI()
		"TextPressed":
			if $MainTextBlock.visible_characters < $MainTextBlock.text.length():
					textPos = $MainTextBlock.text.length()
			else: # if text already finished displaying
				if !textData.is_empty():
					textPos = $MainTextBlock.text.length()
					$MainTextBlock.visible_characters = $MainTextBlock.text.length()
					
					$MainTextBlock.text = $MainTextBlock.text + textData.pop_front()
				else:
					Global.emitSignal("commandComplete","")

func displayNewText(newTextData):
	textData = newTextData
	$MainTextBlock.text = textData.pop_front()
	$MainTextBlock.visible_characters = 0
	textPos = 0

func processText(delta):
	textPos += delta * Global.getSettings("ScrollSpeed")
	$MainTextBlock.visible_characters = textPos

func changeNamecard(data):
	var newName = data[0]
	$Namecard/CenterContainer/RichTextLabel.text = newName
	if newName == "":
		$Namecard.visible = false
	else:
		$Namecard.visible = true
	var frameType = data[1]
	match frameType:
		"basic":
			$Namecard/Background.texture = load("res://Textures/Overlay/Blank.png")
		"silver":
			$Namecard/Background.texture = load("res://Textures/Overlay/Silver.png")
		# TODO add more frame types

func addLog(title,textArr):
	var line = load("res://Scenes/LogEntry.tscn")
	var lineInst = line.instantiate()
	$Log2/ScrollContainer/VBoxContainer.add_child(lineInst)
	
	var log = load("res://Scenes/LogEntry.tscn")
	var logInst = log.instantiate()
	logInst.setTitle(title)
	logInst.setText(textArr)
	$Log2/ScrollContainer/VBoxContainer.add_child(logInst)

func openConfirmMenu(menuText,onConfirm):
	confirmPageVisible = true
	$ConfirmPage/Confirm/RichTextLabel.text = "[center]"+menuText
	purgeConnections()
	$ConfirmPage/Confirm/Confirm.pressed.connect(onConfirm)

func purgeConnections():
	var confirmBtn = $ConfirmPage/Confirm/Confirm
	var connectionsConfirm = confirmBtn.pressed.get_connections()
	
	for connection in connectionsConfirm:
		confirmBtn.pressed.disconnect(connection.callable)

func goToMainMenu():
	Global.setSettings("InMenu",true)
	Global.changeScene("MainMenu")

func closeUI():
	self.visible = false

func closeLog():
	logPageVisible = false

func closeConfirm():
	confirmPageVisible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.visible = true

func createChoices(dataArr): #[ ["Take the girl","Normal","changeScene","girlTaken"] ]
	var choiceScene = load("res://Scenes/Choice.tscn")
	for data in dataArr:
		var scene = choiceScene.instantiate()
		scene.changeText(data[0])
		print("creating : "+data[0])
		scene.changeTexture(data[1])
		scene.changeOnPress(data[2],data[3])
		print(data[2]+" : "+data[3])
		
		$Choices/CenterContainer/VBoxContainer.add_child(scene)
		var bufferBar = choiceScene.instantiate()
		bufferBar.self_modulate.a = 0.0
		$Choices/CenterContainer/VBoxContainer.add_child(bufferBar)

func toggleSkip():
	if Global.getSettings("skipToggled"):
		Global.setSettings("skipToggled",false)
	else:
		Global.setSettings("skipToggled",true)

func toggleAuto():
	if Global.getSettings("autoToggled"):
		Global.setSettings("autoToggled",false)
	else:
		Global.setSettings("autoToggled",true)

func isSkiped():
	return Global.getSettings("skipToggled")

func isAuto():
	return Global.getSettings("autoToggled")
