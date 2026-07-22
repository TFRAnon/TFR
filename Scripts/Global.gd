extends Node

signal updateSaveLoadPage(page)
signal createConfirmDialoge(saveSlotID)
signal refreshSaveSlots
signal refreshWords
signal changeWordPage(newPage)
signal commandComplete
signal displayText(text)
signal displayNameCard(data) # ["new name","frame type"]
signal displayCharacter(data) # ["PickCharacter", "newCharacter"]
signal moveCharacter(data) # ["PickCharacter", "newLocation", "SpeedOfMovement"]
signal makeChoice(data) # [ ["text","button texture","command","commandData" ],["text","button texture","command","commandData" ] ] 
signal changeBackground(data) # textureName
signal loadNewScene()
signal clearChoicesSignal()
signal loadSavedText() # [oldTextData,currentText,visibleChars,oldTextPos]
signal loadsavedChoices()

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
	"currentScene" : "None",
	"skipToggled" : false,
	"autoToggled" : false,
	"RepeatToggled" : false
}

var internalSave : Dictionary = {
	"CurrentTime" : 0,
	"trust" : 0,
	"friendship" : 0,
	"ScenarioBackground" : "",
	"ScenarioCharL" : "",
	"ScenarioCharR" : "",
	"ScenarioCharLLocation" : "",
	"ScenarioCharRLocation" : "",
	"gameDataPosition" : 0,
	"textData" : {},
	"currentText" : "",
	"textPos" : 0,
	"visibleChars" : 0,
	"savedLocation" : "MainMenu",
	"return" : false,
	"characterReturnSilence" : false,
	"atChoices" : false,
	"currentChoices" : [],
	"savedNameCard" : ["","basic"]
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
# "makeChoice", choicesArr[] ( ["text","button texture","command","commandData" ] ) 
# "changeNameCard", "newName", "frame type"




var gameDataDict : Dictionary = {
	"TestScenario" = {
		0 : ["changeBackground","forrest"],
		1 : ["changeText",["This is a test A.","This is a test B.","This is a test C.","This is a test D."]],
		2 : ["changeCharacter","CharRight","StrangerASmile"],
		3 : ["moveCharacter","CharRight","center","1"],
		4 : ["moveCharacter","CharRight","right","1"],
		5 : ["moveCharacter","CharRight","left","1"],
		6 : ["moveCharacter","CharRight","center","0.1"],
		7 : ["moveCharacter","CharRight","right","0.1"],
		8 : ["moveCharacter","CharRight","left","0.1"],
		9 : ["moveCharacter","CharRight","center","0.1"]
	},
	"StartGame" = {
		0 : ["changeBackground","DoorStart"],
		1 : ["changeText",["(In the early hours of the day,","\nthere was light knocking on the door."]],
		2 : ["changeText",["(I didn't plan to meet with anyone today,\nand I don't have any friends who'd drop by without saying so either."," Who could it be?"]],
		3 : ["moveCharacter","CharRight","center","1"],
		4 : ["changeCharacter","CharRight","StrangerASmile"],
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
		21 : ["changeText",["For now, please accept this...","\nAt the time I had nothing on me, so I couldn't even pay for my treatment."]],
		22 : ["changeNameCard","","basic"],
		23 : ["changeText",["(The man handed me an envelope.","\nInside was more money than one would expect for just treatment fees."]],
		24 : ["changeNameCard","Suspicious Man","basic"],
		25 : ["changeText",["My payment was delayed until now, so please consider it as an apology.","\nPlease accept it."]],
		26 : ["changeText",["I have one more thing I brought with me, but...\nMay I come inside before we discuss this?"]],
		27 : ["changeText",["As expected of you, doctor.","\n...Hey, come over here."]],
		28 : ["moveCharacter","CharRight","right","0.1"],
		29 : ["moveCharacter","CharLeft","left","1"],
		30 : ["changeCharacter","CharLeft","Sylvie-rags"],
		31 : ["changeNameCard","","basic"],
		32 : ["changeText",["(The man raises his voice torwards the door, and a girl walks in."]],
		33 : ["changeNameCard","Suspicious Man","basic"],
		34 : ["changeText",["A wealthy person died in an accident recently.","\nHe didn't have any close relatives, so people claiming to be government officials,\nrelatives, and friends came and stole all of his assets."]],
		35 : ["changeText",["I have a few connections here and there so I was able to get some of the leftovers,","\nbut I was also entrusted with a few troublesom items.","\nYes, this one here is one of them."]],
		36 : ["changeText",["I am but a humble merchant now,","and my motto is to buy and sell \"anything,\" so I was told to sell this off somehow, but..."]],
		37 : ["changeText",["When it comes to buying and selling people, it'd be fine if the one in question could be used for more\nmanual labor, but it's not easy finding a buyer for a brat like this.","\nIf I rush things, there is a possibility that I may suffer some losses too."]],
		38 : ["changeText",["It's not like I need to break even on this one, so rather than doing something stupid,\nI thought of either disposing of her or throwing her away, but...","\nEven I have some conscience and compassion"]],
		39 : ["changeText",["I want to avoid anything troubleson, but I didn't even have anywhere I could hand this one off to.\nI was doing business in this town, and then I remembered that you had saved my life once before."]],
		40 : ["changeText",["From what I can tell it seems that you are still living by yourself,","\nand it may be none of my business, but I thought that you may be feeling a bit lonely..."]],
		41 : ["changeText",["It's a bit sudden, but would you take this one in?"]],
		42 : ["changeNameCard","","basic"],
		43 : ["changeText",["(What shall I do?"]],
		44 : ["makeChoice",[
			["Take the girl","Normal","changeScene","girlTaken"],
			["Decline","Bad","changeScene","girlRejected"]
		]]
	},
	"girlTaken" = {
		1 : ["changeNameCard","Suspicious Man","basic"],
		2 : ["changeText",["Is that so! It'll help both me and this girl out."]],
		3 : ["changeText",["This girl is a slave without any relatives.","\nYou can have her help around the house, or if you have such preferences you can treat her like your toy.","\nThere is no one who would object."]],
		4 : ["changeText",["If you want to know more about her, you can ask her.","\nThen, I shall take my leave."]],
		5 : ["changeText",["Once again, thank you very much for saving me that day."]],
		6 : ["changeNameCard","","basic"],
		7 : ["changeCharacter","CharRight","empty"],
		8 : ["moveCharacter","CharLeft","center","0.1"],
		9 : ["changeText",["(The man left."]],
		10 : ["changeNameCard","Sylvie","silver"],
		11 : ["changeCharacter","CharLeft","Sylvie-rags-talk"],
		12 : ["changeText",["Nice to meet you. My name is Sylvie.","\nThank you very much for accepting me."]],
		13 : ["changeText",["I cannot do heavy labor, but I believe I can do any simple chores that you would ask of me."]],
		14 : ["changeCharacter","CharLeft","Sylvie-rags-talk-blink"],
		15 : ["changeText",["However, my previous master enjoyed hearing my screams the most."]],
		16 : ["changeCharacter","CharLeft","Sylvie-rags-talk"],
		17 : ["changeText",["Please... treat me gently..."]],
		18 : ["changeScene","Home"]
		
	},
	"girlRejected" = {
		0 : ["changeCharacter","CharRight","StrangerAFrown"],
		1 : ["changeNameCard","Suspicious Man","basic"],
		2 : ["changeText",["I see.","\nWell, it was sudden so I guess it can't be helped."]],
		3 : ["changeText",["Thank you for your time.","\nI shall take my leave."]],
		4 : ["changeBackground","error"],
		5 : ["changeNameCard","","basic"],
		6 : ["changeText",["(The man left with the girl in tow."]],
		7 : ["changeBackground","gameOver"], # TODO add game over screen
		8 : ["makeChoice",[
			["Show hint","Normal","changeScene","nullRoom"], # TODO replaces button with "The game won't start unless you take her in." make something funnier instead.
			["Load save","Normal","changeRedotScene","LoadGame"], # I hate this name
			["Return to the title screen","Normal","changeRedotScene","MainMenu"]
		]]
	},
	"nullRoom" = {}
}

var imageDict : Dictionary = {
	"gameOver" = "res://Textures/Scenario/black.jpg",
	"error" = "res://Textures/Scenario/black.jpg",
	"empty" = "res://Textures/Scenario/Character/empty.png",
	"DoorStart" = "res://Textures/Scenario/door.jpg",
	"StrangerASmile" = "res://Textures/Scenario/Character/fel_a_smile.png",
	"StrangerAFrown" = "res://Textures/Scenario/Character/fel_a_def.png",
	"forrest" = "res://Textures/Scenario/Crossdale/forest.jpg",
	"Sylvie-rags" = "res://Textures/Scenario/Character/s.png",
	"Sylvie-rags-talk" = "res://Textures/Scenario/Character/s-talk.png",
	"Sylvie-rags-talk-blink" = "res://Textures/Scenario/Character/s-talk-blink.png"
	
}

var talkDict : Dictionary = {
	0 : []
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
		return null

# get values from settings
func getSettings(settingName):
	return settingsDict[settingName]

# set values in settings
func setSettings(settingName, value):
	print("set settings "+settingName+" : "+str(value))
	settingsDict[settingName] = value

# get values from game data
func getGameData(dataName):
	return internalSave[dataName]

# set values in game data
func setGameData(dataName, value):
	print("set gamedata "+dataName+" : "+str(value))
	internalSave[dataName] = value

# function used to change from one scene to another 
func changeScene(sceneName):
	match sceneName:
		"MainMenu":
			setSettings("currentScene","MainMenu")
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
			setGameData("savedLocation","ScenarioPlayer")
			#setSettings("currentScene","TestScenario")
			get_tree().change_scene_to_file("res://Scenes/ScenarioPlayer.tscn")
		"ScenarioPlayer":
			setGameData("savedLocation","ScenarioPlayer")
			get_tree().change_scene_to_file("res://Scenes/ScenarioPlayer.tscn")
		"Home":
			setGameData("savedLocation","Home")
			get_tree().change_scene_to_file("res://Scenes/Home.tscn")
		"Memory":
			get_tree().change_scene_to_file("res://Scenes/Memory.tscn")

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
		"changeCharacter":
			displayCharacter.emit(data)
		"moveCharacter":
			moveCharacter.emit(data)
		"makeChoice":
			makeChoice.emit(data)
		"loadNewScene":
			clearChoicesSignal.emit()
			loadNewScene.emit()
		"loadSavedText":
			loadSavedText.emit()
		"changeBackground":
			print("emitting change background")
			changeBackground.emit(data)
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

func resetInternalSceneData():
	setGameData("ScenarioBackground","")
	setGameData("ScenarioCharL","")
	setGameData("ScenarioCharR","")
	setGameData("ScenarioCharLLocation","")
	setGameData("ScenarioCharRLocation","")
	setGameData("gameDataPosition",0)
	setGameData("textData",{})
	setGameData("currentText","")
	setGameData("textPos",0)
	setGameData("visibleChars",0)
	setGameData("characterReturnSilence",false)
	setGameData("currentChoices",[])
	setGameData("savedNameCard",["","basic"])
