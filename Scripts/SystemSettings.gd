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
	
	# connect sound buttons
	$PageMain/MuteMusic.pressed.connect(setVolumeOrSpeed.bind("MusicVolume",0))
	$PageMain/Music/a.pressed.connect(setVolumeOrSpeed.bind("MusicVolume",0.1))
	$PageMain/Music/a2.pressed.connect(setVolumeOrSpeed.bind("MusicVolume",0.2))
	$"PageMain/Music/1".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",1))
	$"PageMain/Music/2".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",2))
	$"PageMain/Music/3".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",3))
	$"PageMain/Music/4".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",4))
	$"PageMain/Music/5".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",5))
	$"PageMain/Music/6".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",6))
	$"PageMain/Music/7".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",7))
	$"PageMain/Music/8".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",8))
	$"PageMain/Music/9".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",9))
	$"PageMain/Music/10".pressed.connect(setVolumeOrSpeed.bind("MusicVolume",10))
	
	
	# connect effects buttons
	$PageMain/MuteEffects.pressed.connect(setVolumeOrSpeed.bind("EffectVolume",0))
	$PageMain/Effects/a.pressed.connect(setVolumeOrSpeed.bind("EffectVolume",0.1))
	$PageMain/Effects/a2.pressed.connect(setVolumeOrSpeed.bind("EffectVolume",0.2))
	$"PageMain/Effects/1".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",1))
	$"PageMain/Effects/2".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",2))
	$"PageMain/Effects/3".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",3))
	$"PageMain/Effects/4".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",4))
	$"PageMain/Effects/5".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",5))
	$"PageMain/Effects/6".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",6))
	$"PageMain/Effects/7".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",7))
	$"PageMain/Effects/8".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",8))
	$"PageMain/Effects/9".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",9))
	$"PageMain/Effects/10".pressed.connect(setVolumeOrSpeed.bind("EffectVolume",10))
	
	# connect ScrollSpeed buttons
	$"PageMain/ScrollSpeed/1".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",1))
	$"PageMain/ScrollSpeed/2".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",2))
	$"PageMain/ScrollSpeed/3".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",3))
	$"PageMain/ScrollSpeed/4".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",4))
	$"PageMain/ScrollSpeed/5".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",5))
	$"PageMain/ScrollSpeed/6".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",6))
	$"PageMain/ScrollSpeed/7".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",7))
	$"PageMain/ScrollSpeed/8".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",8))
	$"PageMain/ScrollSpeed/9".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",9))
	$"PageMain/ScrollSpeed/10".pressed.connect(setVolumeOrSpeed.bind("ScrollSpeed",10))
	
	# connect AutoScrollSpeed buttons
	$"PageMain/AutoScrollSpeed/1".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",1))
	$"PageMain/AutoScrollSpeed/2".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",2))
	$"PageMain/AutoScrollSpeed/3".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",3))
	$"PageMain/AutoScrollSpeed/4".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",4))
	$"PageMain/AutoScrollSpeed/5".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",5))
	$"PageMain/AutoScrollSpeed/6".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",6))
	$"PageMain/AutoScrollSpeed/7".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",7))
	$"PageMain/AutoScrollSpeed/8".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",8))
	$"PageMain/AutoScrollSpeed/9".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",9))
	$"PageMain/AutoScrollSpeed/10".pressed.connect(setVolumeOrSpeed.bind("AutoScrollSpeed",10))
	
	$ScrollControlOn.pressed.connect(setScrollControl.bind(true))
	$ScrollControlOff.pressed.connect(setScrollControl.bind(false))
	
	refreshMiscControls()
	refreshVolumeButtons()

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

func refreshVolumeButtons():
	# check music mute button
	$PageMain/MuteMusic.disabled = false
	print("checking disabled status")
	print($PageMain/MuteMusic.disabled)
	
	if Global.getSettings("MusicVolume") == 0:
		$PageMain/MuteMusic.disabled = true
	# check music volume buttons
	for node in $PageMain/Music.get_children():
		node.disabled = false
		if Global.getSettings("MusicVolume") == node.name.to_float():
			node.disabled = true
	# check effects mute button
	$PageMain/MuteEffects.disabled = false
	if Global.getSettings("EffectVolume") == 0:
		$PageMain/MuteEffects.disabled = true
	# check effects volume buttons
	for node in $PageMain/Effects.get_children():
		node.disabled = false
		if Global.getSettings("EffectVolume") == node.name.to_float():
			node.disabled = true
	# check scroll speed  buttons
	for node in $PageMain/ScrollSpeed.get_children():
		node.disabled = false
		if Global.getSettings("ScrollSpeed") == node.name.to_float():
			node.disabled = true
	# check auto scroll speed buttons
	for node in $PageMain/AutoScrollSpeed.get_children():
		node.disabled = false
		if Global.getSettings("AutoScrollSpeed") == node.name.to_float():
			node.disabled = true

func refreshMiscControls():
	if Global.getSettings("ScrollControls"):
		$ScrollControlOn.disabled = true
		$ScrollControlOff.disabled = false
	else:
		$ScrollControlOn.disabled = false
		$ScrollControlOff.disabled = true

func exitButton():
	match Global.getSettings("InMenu"):
		true:
			Global.changeScene("MainMenu")
		false:
			Global.changeScene("ScenarioPlayer")

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

func setVolumeOrSpeed(settingName,newVol):
	print(settingName+" set to "+str(newVol))
	Global.setSettings(settingName,newVol)
	refreshVolumeButtons()

func setScrollControl(boolean):
	print("setting scroll controls to : "+str(boolean))
	Global.setSettings("ScrollControls",boolean)
	refreshMiscControls()
