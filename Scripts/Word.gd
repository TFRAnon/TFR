extends Control

var blacklist = ["breasts","mouth","penis","orgasm","oral","love juices"]

var pagenumber = "null"
var slotID = "null"
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Delete.pressed.connect(delete)
	Global.refreshWords.connect(refresh)
	Global.changeWordPage.connect(changePage)

func setIDandIndex(newID, newIndex):
	slotID = newID # which set of boxes is this
	index = newIndex # location in set of 4

func changeText(text):
	$RichTextLabel.text = text

func changePage(newPage):
	pagenumber = newPage
	refresh()

func delete():
	Global.removeWord($RichTextLabel.text,pagenumber+slotID)

func refresh():
	print(self.name + " : refreshing")
	var textArr = Global.getWord(pagenumber+slotID)
	#if (pagenumber+slotID+":"+str(index) == "pg1-1:1"):
		#print("here")
	if index > 0 and index <= textArr.size():
		$RichTextLabel.text = textArr[index-1]
		print(self.name + " : text set to : "+$RichTextLabel.text)
	else:
		$RichTextLabel.text = ""
		print(self.name + " : text set to : NA")
	if $RichTextLabel.text.is_empty():
		self.visible = false;
	else:
		self.visible = true;
