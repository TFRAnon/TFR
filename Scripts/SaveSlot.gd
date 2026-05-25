extends TextureButton

var buttonValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initial value becomes ones portion of slot id. Do not change, used for single digit position.
	buttonValue = int(str(self.name))
	self.pressed.connect(saveSlotPressed)
	$Delete.pressed.connect(delete)
	Global.updateSaveLoadPage.connect(changePage)
	Global.refreshSaveSlots.connect(refresh)
	checkNewTag()
	loadData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# function triggered when page is changed, updates the pagenumber
func changePage(pageNumber):
	var newText = str(((int(str(pageNumber))-1)*10)+buttonValue)
	$SlotNumber.text = newText
	checkNewTag()
	loadData()

func saveSlotPressed():
	match Global.getSettings("SaveLoadBG"):
		"save":
			Global.createSaveSlot($SlotNumber.text)
		"load":
			Global.loadFromSlot($SlotNumber.text)

func checkNewTag():
	if ($SlotNumber.text == Global.getSettings("lastSave")):
		$New.visible = true
	else:
		$New.visible = false

func loadData():
	if(Global.doesSaveExists($SlotNumber.text)):
		$"Date-Time".text = "####/##/##    ##:##:##"
		$RecentMessage.text = "==Recent Message=="
		$Delete.visible = true
	else:
		$"Date-Time".text = ""
		$RecentMessage.text = "No Save Data Exists."
		$Delete.visible = false

func delete():
	print("delete pressed")
	Global.emitSignal("createConfirmDialoge",$SlotNumber.text)

func refresh():
	loadData()
