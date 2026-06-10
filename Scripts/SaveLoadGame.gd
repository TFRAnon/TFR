extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connect buttons
	for button in $Pages.get_children():
		button.pressed.connect(changePage.bind(button.name,button))
	$ExitButton.pressed.connect(exitButton)
	loadBackground()
	# init everything to page 1
	changePage("1",$"Pages/1")
	# connect
	Global.createConfirmDialoge.connect(createConfirm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# function to change the page and emit signal for all save slots to update
func changePage(pageNumber,button):
	print("changing page to : "+str(pageNumber))
	# update save slot instances
	Global.emitSignal("PageChange",pageNumber)
	# clear disabled
	for tempButton in $Pages.get_children():
		tempButton.disabled = false
	
	button.disabled = true

func exitButton():
	match Global.getSettings("InMenu"):
		true:
			Global.changeScene("MainMenu")
		false:
			Global.changeScene("ScenarioPlayer")

func loadBackground():
	match Global.getSettings("SaveLoadBG"):
		"save":
			$Background.texture = load("res://Textures/Save-Load/bg_save.png")
		"load":
			$Background.texture = load("res://Textures/Save-Load/bg_load.png")

func createConfirm(saveSlotID):
	print("creating confirm for save slot : "+saveSlotID)
	var menu = preload("res://Scenes/Confirm.tscn")
	var menuInstance = menu.instantiate()
	self.add_child(menuInstance)
	menuInstance.setSaveSlotID(saveSlotID)
	menuInstance.setText("[center]Are you sure you want to delete Save "+str(saveSlotID)+"?")
