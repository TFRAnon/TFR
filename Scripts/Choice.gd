extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.clearChoicesSignal.connect(clear)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeText(newText):
	$CenterContainer/RichTextLabel.text = newText

func changeTexture(newTexture):
	match newTexture:
		"Normal":
			var regTexture = load("res://Textures/Overlay/ChoiceUI/reg_white.png")
			var hoverTexture = load("res://Textures/Overlay/ChoiceUI/reg_hover.png")
			
			self.texture_normal = regTexture
			self.texture_hover = hoverTexture 
			
		"Bad":
			var regTexture = load("res://Textures/Overlay/ChoiceUI/bad_white.png")
			var hoverTexture = load("res://Textures/Overlay/ChoiceUI/bad_hover.png")
			
			self.texture_normal = regTexture
			self.texture_hover = hoverTexture

func changeOnPress(action,data):
	match action:
		"changeScene":
			Global.setSettings("currentScene",data)
			self.pressed.connect(Global.emitSignal.bind("loadNewScene","N/A"))
		"changeRedotScene":
			self.pressed.connect(Global.changeScene.bind(data))

func clear():
	self.queue_free()
