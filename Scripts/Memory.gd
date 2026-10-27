extends Node2D

var mode
var currentPage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Page1.pressed.connect(changePage.bind("1"))
	$Page2.pressed.connect(changePage.bind("2"))
	$Page1.disabled = true
	currentPage = "1"
	
	$Scenes.pressed.connect(changeMode.bind("scenes"))
	$CgMode.pressed.connect(changeMode.bind("cgmode"))
	$Guide.pressed.connect(changeMode.bind("guide"))
	$Back.pressed.connect(returnHome)
	
	$Page1Nodes/FirstTime.pressed.connect(goToPlayer.bind("First_Inside_LowLust"))
	$Page1Nodes/Kitchen1.pressed.connect(goToPlayer.bind("Kitchen_1"))
	
	if Global.getGameData("CGMode"):
		$CgMode.disabled = true
		mode = "cgmode"
	else:
		$Scenes.disabled = true
		mode = "Scenes"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeMode(newMode):
	mode = newMode
	$Scenes.disabled = false
	$CgMode.disabled = false
	$Guide.disabled = false
	match newMode:
		"scenes":
			$Scenes.disabled = true
			Global.setGameData("CGMode",false);
			changePage(currentPage)
		"cgmode":
			$CgMode.disabled = true
			Global.setGameData("CGMode",true);
			changePage(currentPage)
		"guide":
			$Guide.disabled = true
			changePage(currentPage)

func changePage(page):
	$GuideBackground.visible = false
	match page:
		"1":
			currentPage = "1"
			if mode == "guide":
				$Page1Nodes.visible = false
				$Page2Nodes.visible = false
				$GuideBackground.texture = load("res://Textures/Memory/memory_hint1.jpg")
				$GuideBackground.visible = true
			else:
				$Page1Nodes.visible = true
				$Page2Nodes.visible = false
			$Page1.disabled = true
			$Page2.disabled = false
		"2":
			currentPage = "2"
			if mode == "guide":
				$Page1Nodes.visible = false
				$Page2Nodes.visible = false
				$GuideBackground.texture = load("res://Textures/Memory/memory_hint2.jpg")
				$GuideBackground.visible = true
			else:
				$Page1Nodes.visible = false
				$Page2Nodes.visible = true
			$Page1.disabled = false
			$Page2.disabled = true

func returnHome():
	Global.changeScene("Home")

func goToPlayer(sceneName):
	Global.setGameData("CurrentMemory",sceneName)
	Global.setGameData("CGPlayerReturnLocation","Memory")
	Global.changeScene("CGPlayer")
