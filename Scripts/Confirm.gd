extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/Bace/Cancel.pressed.connect(close)
	$CenterContainer/Bace/Confirm.pressed.connect(doAction)

var saveSlotID

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func close():
	self.queue_free()

func doAction():
	Global.deleteSave(saveSlotID)
	self.queue_free()

func setText(text):
	$CenterContainer/Bace/RichTextLabel.text = text;

func setSaveSlotID(id):
	saveSlotID = id
