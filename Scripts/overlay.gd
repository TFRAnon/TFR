extends Node2D

var logPageVisible
var confirmPageVisible

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
	
	$LogPage/ExitButton.pressed.connect(closeLog)
	logPageVisible = false
	confirmPageVisible = false
	
	$ConfirmPage/Confirm/Cancel.pressed.connect(closeConfirm)


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
			pass

func changeNamecard(newName):
	$Namecard/CenterContainer/RichTextLabel.text = newName
	if newName.isEmpty():
		$Namecard.visible = false
	else:
		$Namecard.visible = true

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

func closeLog():
	logPageVisible = false

func closeConfirm():
	confirmPageVisible = false
