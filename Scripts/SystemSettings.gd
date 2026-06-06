extends Node2D

var currentPage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PageMain/FullScreen.pressed.connect(Global.toggleFullScreen)
	$GameSettings.pressed.connect(changePage.bind("0"))
	$Page1Button.pressed.connect(changePage.bind("1"))
	$Page2Button.pressed.connect(changePage.bind("2"))
	$Back.pressed.connect(exitButton)
	$GameSettings.disabled = true;
	
	$AddWordSegment/AddWord1.pressed.connect(addWord.bind("1"))
	$AddWordSegment/AddWord2.pressed.connect(addWord.bind("2"))
	$AddWordSegment/AddWord3.pressed.connect(addWord.bind("3"))
	$AddWordSegment/AddWord4.pressed.connect(addWord.bind("4"))
	$AddWordSegment/AddWord5.pressed.connect(addWord.bind("5"))
	$AddWordSegment/AddWord6.pressed.connect(addWord.bind("6"))
	
	
	# initialize word objects
	$Words/Word.setIDandIndex("1",1)
	$Words/Word2.setIDandIndex("1",2)
	$Words/Word3.setIDandIndex("1",3)
	$Words/Word4.setIDandIndex("1",4)
	$Words/Word5.setIDandIndex("2",1)
	$Words/Word6.setIDandIndex("2",2)
	$Words/Word7.setIDandIndex("2",3)
	$Words/Word8.setIDandIndex("2",4)
	$Words/Word9.setIDandIndex("3",1)
	$Words/Word10.setIDandIndex("3",2)
	$Words/Word11.setIDandIndex("3",3)
	$Words/Word12.setIDandIndex("3",4)
	$Words/Word13.setIDandIndex("4",1)
	$Words/Word14.setIDandIndex("4",2)
	$Words/Word15.setIDandIndex("4",3)
	$Words/Word16.setIDandIndex("4",4)
	$Words/Word17.setIDandIndex("5",1)
	$Words/Word18.setIDandIndex("5",2)
	$Words/Word19.setIDandIndex("5",3)
	$Words/Word20.setIDandIndex("5",4)
	$Words/Word21.setIDandIndex("6",1)
	$Words/Word22.setIDandIndex("6",2)
	$Words/Word23.setIDandIndex("6",3)
	$Words/Word24.setIDandIndex("6",4)
	#Global.emitSignal("changeWordPage","pg0-")
	#Global.emitSignal("refreshWords",null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changePage(pageNumber):
	resetMenuButtons()
	match pageNumber:
		"0":
			currentPage = "pg0-"
			$GameSettings.disabled = true;
			$Background.texture = load("res://Textures/Config/config_sys.jpg")
			
			$PageMain.visible = true
			$AddWordSegment.visible = false
			$Words.visible = false
		"1":
			currentPage = "pg1-"
			$Page1Button.disabled = true;
			$Background.texture = load("res://Textures/Config/config_word_a.jpg")
			Global.emitSignal("changeWordPage","pg1-")
			
			$PageMain.visible = false
			$AddWordSegment.visible = true
			$Words.visible = true
		"2":
			currentPage = "pg2-"
			$Page2Button.disabled = true;
			$Background.texture = load("res://Textures/Config/config_word_b.jpg")
			Global.emitSignal("changeWordPage","pg2-")
			
			$PageMain.visible = false
			$AddWordSegment.visible = true
			$Words.visible = true

func resetMenuButtons():
	$GameSettings.disabled = false;
	$Page1Button.disabled = false;
	$Page2Button.disabled = false;
	$Back.disabled = false;

func exitButton():
	Global.changeScene("MainMenu")

func addWord(location):
	if not getTextFromLocation(location).is_empty():
		Global.addWord(getTextFromLocation(location),currentPage+location)
		clearTextFromLocation(location)

func getTextFromLocation(location):
	match location:
		"1":
			return $AddWordSegment/TextEdit1.text
		"2":
			return $AddWordSegment/TextEdit2.text
		"3":
			return $AddWordSegment/TextEdit3.text
		"4":
			return $AddWordSegment/TextEdit4.text
		"5":
			return $AddWordSegment/TextEdit5.text
		"6":
			return $AddWordSegment/TextEdit6.text

func clearTextFromLocation(location):
	match location:
		"1":
			$AddWordSegment/TextEdit1.text = ""
		"2":
			$AddWordSegment/TextEdit2.text = ""
		"3":
			$AddWordSegment/TextEdit3.text = ""
		"4":
			$AddWordSegment/TextEdit4.text = ""
		"5":
			$AddWordSegment/TextEdit5.text = ""
		"6":
			$AddWordSegment/TextEdit6.text = ""
