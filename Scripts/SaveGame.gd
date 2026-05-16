extends Node2D

var currentPage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connect buttons
	for button in $Pages.get_children():
		button.pressed.connect(changePage.bind(button.name,button))
	$ExitButton.pressed.connect(exitButton)
	# init first page
	changePage("1",$"Pages/1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func changePage(pageNumber,button):
	currentPage = pageNumber
	# clear disabled
	for tempButton in $Pages.get_children():
		tempButton.disabled = false
	
	button.disabled = true
	print(pageNumber)

func exitButton():
	Global.changeScene("MainMenu")
