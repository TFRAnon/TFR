extends TextureButton

var buttonValue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initial value becomes ones portion of slot id
	buttonValue = int(str(self.name))
	self.pressed.connect(saveSlotPressed)
	Global.updateSaveLoadPage.connect(changePage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# function triggered when page is changed, updates the pagenumber
func changePage(pageNumber):
	var newText = str(((int(str(pageNumber))-1)*10)+buttonValue)
	$SlotNumber.text = newText

func saveSlotPressed():
	Global.createSaveSlot($SlotNumber.text)
