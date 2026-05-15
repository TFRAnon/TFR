extends VideoStreamPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureButton.pressed.connect(endVideo)
	self.finished.connect(endVideo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func endVideo():
	print("Video over, moving to main menu")
	Global.changeScene("MainMenu")
