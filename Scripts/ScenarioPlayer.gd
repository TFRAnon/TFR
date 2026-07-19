extends Node2D

var dataDict : Dictionary

var state : states = states.CONTINUE
enum states {
	WAIT,
	CONTINUE
}

var currentPosition : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.commandComplete.connect(waitOver)
	Global.loadNewScene.connect(loadNewScene)
	Global.changeBackground.connect(changeBackground)
	
	loadData()
	print("loaded scenario : " + Global.getSettings("currentScene"))
	if Global.getGameData("return"):
		loadOldData()
		state = states.WAIT
	else:
		currentPosition = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		states.WAIT:
			pass
		states.CONTINUE:
			processLine()

func loadNewScene():
	loadData()
	print("loaded scenario : " + Global.getSettings("currentScene"))
	currentPosition = 0;

func loadData():
	dataDict = Global.getCurrentSceneData()

func waitOver():
	state = states.CONTINUE

func changeBackground(textureName):
	print("changing background to : "+str(textureName))
	var texture = load(Global.getImage(textureName))
	if texture:
		$Background.texture = texture
		Global.setGameData("ScenarioBackground",textureName)
	else:
		print("Failed to load texture from :"+str(textureName))

# "changeText", [text,text,text]
# "changeBackground", "newBackground"
# "changeCharacter", "PickCharacter", "newCharacter" 
# "moveCharacter", "PickCharacter", "newLocation", "SpeedOfMovement"
# "makeChoice", choicesArr[]
# "changeNameCard", "newName", "frame type"

func processLine():
	var command = dataDict.get(currentPosition, ["NA"])
	if command[0] != "NA":
		print("processing command : "+str(command))
		Global.setGameData("atChoices",false) # reset flag
	match command[0]:
		"changeText":
			Global.emitSignal("displayText",command[1])
			state = states.WAIT
		"changeBackground":
			changeBackground(command[1])
		"changeCharacter":
			Global.emitSignal(command[0],[command[1],command[2]])
		"moveCharacter":
			Global.emitSignal(command[0],[command[1],command[2],command[3]])
			state = states.WAIT
		"makeChoice":
			Global.setGameData("atChoices",true) # flag to recreate choices if navigated away from and back to scene
			Global.setGameData("currentChoices",command[1])
			Global.emitSignal(command[0],command[1])
		"changeNameCard":
			Global.emitSignal(command[0],[command[1],command[2]])
		"changeScene":
			Global.changeScene(command[1])
	currentPosition = currentPosition + 1
	Global.setGameData("gameDataPosition",currentPosition)

func loadOldData():
	Global.emitSignal("changeBackground",Global.getGameData("ScenarioBackground"))
	currentPosition = Global.getGameData("gameDataPosition")
	Global.emitSignal("changeCharacter",["CharRight",Global.getGameData("ScenarioCharR")])
	Global.emitSignal("changeCharacter",["CharLeft",Global.getGameData("ScenarioCharL")])
	Global.emitSignal("moveCharacter",["CharRight",Global.getGameData("ScenarioCharRLocation"),1])
	Global.emitSignal("moveCharacter",["CharLeft",Global.getGameData("ScenarioCharLLocation"),1])
	Global.emitSignal("loadSavedText","N/A")
	if Global.getGameData("atChoices"):
		Global.emitSignal("makeChoice",Global.getGameData("currentChoices"))
	Global.emitSignal("commandComplete","N/A")
