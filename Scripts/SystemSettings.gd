extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PageMain/FullScreen.pressed.connect(Global.toggleFullScreen)
	$GameSettings.pressed.connect(changePage.bind("0"))
	$Page1Button.pressed.connect(changePage.bind("1"))
	$Page2Button.pressed.connect(changePage.bind("2"))
	$Back.pressed.connect(exitButton)
	$GameSettings.disabled = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changePage(pageNumber):
	resetMenuButtons()
	match pageNumber:
		"0":
			$GameSettings.disabled = true;
			$Background.texture = load("res://Textures/Config/config_sys.jpg")
			for child in $PageMain.get_children():
				child.visible = true
			for child in $Page1.get_children():
				child.visible = false
			for child in $Page2.get_children():
				child.visible = false
		"1":
			$Page1Button.disabled = true;
			$Background.texture = load("res://Textures/Config/config_word_a.jpg")
			for child in $PageMain.get_children():
				child.visible = false
			for child in $Page1.get_children():
				child.visible = true
			for child in $Page2.get_children():
				child.visible = false
		"2":
			$Page2Button.disabled = true;
			$Background.texture = load("res://Textures/Config/config_word_b.jpg")
			for child in $PageMain.get_children():
				child.visible = false
			for child in $Page1.get_children():
				child.visible = false
			for child in $Page2.get_children():
				child.visible = true

func resetMenuButtons():
	$GameSettings.disabled = false;
	$Page1Button.disabled = false;
	$Page2Button.disabled = false;
	$Back.disabled = false;

func exitButton():
	Global.changeScene("MainMenu")
