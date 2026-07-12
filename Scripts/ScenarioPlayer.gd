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
	loadData()
	print("loaded scenario : "+str(dataDict))
	currentPosition = 0;
	Global.commandComplete.connect(waitOver)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		states.WAIT:
			pass
		states.CONTINUE:
			processLine()

func loadData():
	dataDict = Global.getCurrentSceneData()

func waitOver():
	state = states.CONTINUE

# "changeText", [text,text,text]
# "changeBackground", "newBackground"
# "changeCharacter", "PickCharacter", "newCharacter" 
# "moveCharacter", "PickCharacter", "newLocation", "SpeedOfMovement"
# "makeChoice", choicesArr[]
# "changeNameCard", "newName", "frame type"

func processLine():
	var command = dataDict.get(currentPosition, ["NA"])
	if command[0] != "NA":
		print("processing command : "+command[0])
	match command[0]:
		"changeText":
			Global.emitSignal("displayText",command[1])
			state = states.WAIT
		"changeBackground":
			var texture = load(Global.getImage(command[1]))
			if texture:
				$Background.texture = texture
			else:
				print("Failed to load texture from :"+str(command[1]))
		"changeCharacter":
			Global.emitSignal(command[0],[command[1],command[2]])
		"moveCharacter":
			Global.emitSignal(command[0],[command[1],command[2],command[3]])
			state = states.WAIT
		"makeChoice":
			pass
		"changeNameCard":
			Global.emitSignal(command[0],[command[1],command[2]])
	currentPosition = currentPosition + 1

# ["changeCharacter","CharRight","StrangerASmile"]
# ["moveCharacter","CharRight","center","1"]
