extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connect buttons
	for button in $Pages.get_children():
		button.pressed.connect(changePage.bind(button.name,button))
	$ExitButton.pressed.connect(exitButton)
	loadBackground()


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
	Global.changeScene("MainMenu")

func loadBackground():
	match Global.getSettings("SaveLoadBG"):
		"save":
			$Background.texture = load("res://Textures/Save-Load/bg_save.png")
		"load":
			$Background.texture = load("res://Textures/Save-Load/bg_load.png")
