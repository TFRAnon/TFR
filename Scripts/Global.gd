extends Node

signal updateSaveLoadPage(page)
signal createConfirmDialoge(saveSlotID)
signal refreshSaveSlots
signal refreshWords
signal changeWordPage(newPage)
signal commandComplete
signal displayText(text)
signal displayNameCard(data) # ["new name","frame type"]

# dictionary containing game settings and flags
var settingsDict = {
	"fullscreen" : false,
	"lastSave" : "0",
	"SaveLoadBG" : "save",
	"MusicVolume" : 5,
	"EffectVolume" : 5,
	"ScrollSpeed" : 10,
	"AutoScrollSpeed" : 5,
	"ScrollControls" : false,
	"InMenu" : true,
	"currentScene" : "None"
}

var customWordDict = {
	"pg1-1" = ["crotch","genitals"],
	"pg1-2" = ["clitoris","clit"],
	"pg1-3" = ["breasts"],
	"pg1-4" = ["pussy","vagina"],
	"pg1-5" = ["womb","uterus"],
	"pg1-6" = ["mouth"],
	"pg2-1" = ["penis"],
	"pg2-2" = ["sex","intercourse"],
	"pg2-3" = ["semen","cum"],
	"pg2-4" = ["orgasm"],
	"pg2-5" = ["oral"],
	"pg2-6" = ["love juices"]
}

# "changeText", [text,text,text]
# "changeBackground", "newBackground"
# "changeCharacter", "PickCharacter", "newCharacter" 
# "moveCharacter", "PickCharacter", "newLocation", "SpeedOfMovement"
# "makeChoice", choicesArr[]
# "changeNameCard", "newName", "frame type"




var gameDataDict : Dictionary = {
	"TestScenario" = {
		0 : ["changeBackground","forrest"],
		1 : ["changeText",["This is a test A.","This is a test B.","This is a test C.","This is a test D."]]
	},
	"StartGame" = {
		0 : ["changeBackground","DoorStart"],
		1 : ["changeText",["(In the early hours of the day,","\nthere was light knocking on the door."]],
		2 : ["changeText",["(I didn't plan to meet with anyone today,\nand I don't have any friends who'd drop by without saying so either."," Who could it be?"]],
		3 : ["changeCharacter","CharRight","StrangerASmile"],
		4 : ["moveCharacter","CharRight","center","0"],
		5 : ["changeNameCard","Suspicious Man","basic"],
		6 : ["changeText",["Greetings, doctor."]],
		7 : ["changeNameCard","","basic"],
		8 : ["changeText",["(I opened the door and there was a suspicious middle-aged man standing in front of my house."]],
		9 : ["changeNameCard","Suspicious Man","basic"],
		10 : ["changeText",["Do you remember me?","\nYou saved my life in the past."]],
		11 : ["changeNameCard","","basic"],
		12 : ["changeText",["(I look at the man's face and try to remember.","\n...Now that he mentions it, I do vaguely recognize his face."]],
		13 : ["changeNameCard","Suspicious Man","basic"],
		14 : ["changeText",["Thats right. Long ago you saved me when I had collapsed in the outskirts of town."]],
		15 : ["changeText",["Even though you knew involving yourself would bring nothing but trouble...","\nI wonder if it's just in a doctor's nature."]],
		16 : ["changeText",["I apologize that I left at that time without thanking you properly","\nI happened to be nearby, so I thought I'd come to give my thanks"]],
		17 : ["changeNameCard","","basic"],
		18 : ["changeText",["(He's certainly suspicious, but he went out of his way to come thank me.\nMaybe I should make some tea..."]],
		19 : ["changeNameCard","Suspicious Man","basic"],
		20 : ["changeText",["Oh no, I'm fine. I don't plan to take too much of your time."]],
		21 : ["changeText",["For now, please accept this..."]]
	}
}

var imageDict : Dictionary = {
	"error" = "res://Textures/Scenario/black.jpg",
	"DoorStart" = "res://Textures/Scenario/door.jpg",
	"StrangerASmile" = "res://Textures/Scenario/Character/fel_a_smile.png",
	"forrest" = "res://Textures/Scenario/Crossdale/forest.jpg"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onStartUp()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func removeWord(word,slot):
	var arr = customWordDict[slot]
	arr.erase(word)
	refreshWords.emit()

func addWord(word,slot):
	var arr = customWordDict[slot]
	arr.append(word)
	refreshWords.emit()

func getWord(key):
	var arr = customWordDict[key].duplicate(true)
	return arr

func getCurrentSceneData():
	var currentScene = getSettings("currentScene")
	return gameDataDict[currentScene].duplicate(true)

func setCurrentScene(newScene):
	if gameDataDict.has(newScene):
		setSettings("currentScene",newScene)
	else:
		print("error failed to load set scene : "+str(newScene))

func getImage(imageName):
	if imageDict.has(imageName):
		print("loading image : "+str(imageName))
		return imageDict[imageName]
	else:
		print("error during loading image : "+str(imageName))
		return imageDict["error"]

# get values from settings
func getSettings(settingName):
	return settingsDict[settingName]

# set values in settings
func setSettings(settingName, value):
	settingsDict[settingName] = value

# function used to change from one scene to another 
func changeScene(sceneName):
	match sceneName:
		"MainMenu":
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		"LoadGame":
			setSettings("SaveLoadBG","load")
			get_tree().change_scene_to_file("res://Scenes/SaveLoadGame.tscn")
		"SaveGame":
			setSettings("SaveLoadBG","save")
			get_tree().change_scene_to_file("res://Scenes/SaveLoadGame.tscn")
		"ReadMe":
			get_tree().change_scene_to_file("res://Scenes/ReadMe.tscn")
		"Credit":
			get_tree().change_scene_to_file("res://Scenes/Credit.tscn")
		"Config":
			get_tree().change_scene_to_file("res://Scenes/SystemSettings.tscn")
		"UpdateHistory":
			get_tree().change_scene_to_file("res://Scenes/History.tscn")
		"NewGame":
			setSettings("currentScene","StartGame")
			get_tree().change_scene_to_file("res://Scenes/ScenarioPlayer.tscn")
		"ScenarioPlayer":
			get_tree().change_scene_to_file("res://Scenes/ScenarioPlayer.tscn")
			

# toggles full screen
func toggleFullScreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# apply settings on startup if needed
func onStartUp():
	if settingsDict["fullscreen"] == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# creates a save file with name as saveSlotID
func createSaveSlot(saveSlotID):
	print("creating save slot at : "+saveSlotID)
	if (doesSaveExists(saveSlotID)):
		deleteSave(saveSlotID)
	var file = FileAccess.open("user://"+saveSlotID, FileAccess.WRITE)
	if file: # if file is not null
		file.store_string(JSON.stringify(settingsDict))
		file.close()
		setSettings("lastSave",saveSlotID)
	else: # error occured
		print("save failed")
		print(FileAccess.get_open_error())
	refreshSaveSlots.emit()

func loadFromSlot(saveSlotID):
	print("loading slot from : "+saveSlotID)
	if (doesSaveExists(saveSlotID)):
		var saveFile = FileAccess.open("user://"+saveSlotID, FileAccess.READ)
		if saveFile: # if file is not null
			var dataDict = JSON.parse_string(saveFile.get_as_text())
			# Load data from dataDict created by save slot
		else: # error occured
			print("failed to load")
			print(FileAccess.get_open_error())
	else:
		print("error : save slot does not exist")

# emits a signal 
func emitSignal(signalName,data):
	print("signal emitted : "+signalName)
	match signalName:
		"PageChange":
			print(signalName+" emitted with : "+str(data))
			updateSaveLoadPage.emit(data)
		"createConfirmDialoge": # spawns a confirmation menu for the save slot
			createConfirmDialoge.emit(data)
		"changeWordPage":
			changeWordPage.emit(data)
		"refreshWords":
			refreshWords.emit()
		"commandComplete":
			commandComplete.emit()
		"displayText":
			displayText.emit(data)
		"changeNameCard":
			displayNameCard.emit(data)
			

# checks to see if saveName exists. returns True or False
func doesSaveExists(saveName):
	if FileAccess.file_exists("user://"+saveName):
		return true
	else:
		return false

# function used to delete save file
func deleteSave(saveName):
	print("deleteing save : "+saveName)
	if FileAccess.file_exists("user://"+saveName):
		var result = DirAccess.remove_absolute("user://"+saveName)
		if result == OK:
			print("Deleted")
		else:
			print("Failed to delete File : "+"user://"+saveName)
	else:
		print("error : file does not exist? : "+"user://"+saveName)
	refreshSaveSlots.emit()
