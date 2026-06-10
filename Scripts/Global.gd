extends Node

signal updateSaveLoadPage(page)
signal createConfirmDialoge(saveSlotID)
signal refreshSaveSlots
signal refreshWords
signal changeWordPage(newPage)

# dictionary containing game settings 
var settingsDict = {
	"fullscreen" : false,
	"lastSave" : "0",
	"SaveLoadBG" : "save",
	"MusicVolume" : 5,
	"EffectVolume" : 5,
	"ScrollSpeed" : 5,
	"AutoScrollSpeed" : 5,
	"ScrollControls" : false,
	"InMenu" : true
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
			# set newgame tag
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
