extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Bace.pressed.connect(buttonPressed.bind("Bace"))
	$VBoxContainer/Command.pressed.connect(buttonPressed.bind("Command"))
	$VBoxContainer/CommandAct.pressed.connect(buttonPressed.bind("CommandAct"))
	$VBoxContainer/CommandSub.pressed.connect(buttonPressed.bind("CommandSub"))
	$VBoxContainer/Status.pressed.connect(buttonPressed.bind("Status"))
	$VBoxContainer/Outside.pressed.connect(buttonPressed.bind("Outside"))
	$VBoxContainer/DressUp.pressed.connect(buttonPressed.bind("DressUp"))
	$VBoxContainer/Communicate.pressed.connect(buttonPressed.bind("Communicate"))
	$VBoxContainer/Bed.pressed.connect(buttonPressed.bind("Bed"))
	$Question.pressed.connect(buttonPressed.bind("Question"))
	$Trivia.pressed.connect(buttonPressed.bind("Trivia"))
	$Credit.pressed.connect(buttonPressed.bind("Credit"))
	$Return.pressed.connect(buttonPressed.bind("Return"))
	buttonPressed("Bace")



func buttonPressed(buttonName):
	clearButtons()
	match buttonName:
		"Bace":
			$Background.texture = load("res://Textures/ReadMe/bace.jpg")
			$Bace.disabled = true
		"Command":
			$Background.texture = load("res://Textures/ReadMe/command.jpg")
			$VBoxContainer/Command.disabled = true
		"CommandAct":
			$Background.texture = load("res://Textures/ReadMe/command_act.jpg")
			$VBoxContainer/CommandAct.disabled = true
		"CommandSub":
			$Background.texture = load("res://Textures/ReadMe/command_sub.jpg")
			$VBoxContainer/CommandSub.disabled = true
		"Status":
			$Background.texture = load("res://Textures/ReadMe/status.jpg")
			$VBoxContainer/Status.disabled = true
		"Outside":
			$Background.texture = load("res://Textures/ReadMe/out_side.jpg")
			$VBoxContainer/Outside.disabled = true
		"DressUp":
			$Background.texture = load("res://Textures/ReadMe/dress_up.jpg")
			$VBoxContainer/DressUp.disabled = true
		"Communicate":
			$Background.texture = load("res://Textures/ReadMe/communicate.jpg")
			$VBoxContainer/Communicate.disabled = true
		"Bed":
			$Background.texture = load("res://Textures/ReadMe/bed.jpg")
			$VBoxContainer/Bed.disabled = true
		"Question":
			$Background.texture = load("res://Textures/ReadMe/question.jpg")
			$Question.disabled = true
		"Trivia":
			$Background.texture = load("res://Textures/ReadMe/trivia.jpg")
			$Trivia.disabled = true
		"Credit":
			$Background.texture = load("res://Textures/ReadMe/credit.jpg")
			$Credit.disabled = true
		"Return":
			Global.changeScene("MainMenu")

# re-enables all disabled buttons
func clearButtons():
	# clear buttons not in VBox
	for child in self.get_children():
		if child.is_class("TextureButton"):
			child.disabled = false
	# clear buttons in VBox
	for child in $VBoxContainer.get_children():
		if child.is_class("TextureButton"):
			child.disabled = false
