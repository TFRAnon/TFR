extends Node

signal updateSaveLoadPage(page)

# dictionary containing game settings 
var settingsDict = {
	"fullscreen" : false,
	"lastSave" : "0",
	"SaveLoadBG" : "save"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onStartUp()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



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

func createSaveSlot(saveSlotID):
	print("creating save slot at : "+saveSlotID)

func loadFromSlot(saveSlotID):
	print("loading slot from : "+saveSlotID)

func emitSignal(signalName,data):
	match signalName:
		"PageChange":
			print(signalName+" emitted with : "+str(data))
			updateSaveLoadPage.emit(data)

# checks to see if saveName exists. returns True or False
func doesSaveExists(saveName):
	if FileAccess.file_exists("user://"+saveName):
		return true
	else:
		return false

# function to create a new savefile with name saveName
func createSave(saveName):
	print("creating save : "+saveName)
	var data = "test"
	var file = FileAccess.open("user://"+saveName, FileAccess.WRITE)
	file.store_string(data)
	file.close()

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
