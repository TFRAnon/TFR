extends Node2D

var historyTextDict = {
	"1_0_0" : "[center][b]Version History[/b][/center]\n \n [color=yellow][b]v1.4.2[/b][/color]\n • Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n • Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n • Fixed issue where vestibulum ante ipsum primis would occasionally fail to load.\n • Improved performance of cursus euismod quis viverra nibh.\n \n [color=yellow][b]v1.4.1[/b][/color]\n • Added support for tincidunt nunc pulvinar sapien et ligula.\n • Updated aliquet lectus proin nibh nisl condimentum id venenatis.\n • Minor UI adjustments to faucibus vitae aliquet nec ullamcorper.\n \n [color=lime][b]v1.4.0[/b][/color]\n \n [b]New Features[/b]\n • Introduced magna fermentum iaculis eu non diam phasellus.\n • Added configurable pellentesque habitant morbi tristique senectus.\n • New dashboard for commodo elit at imperdiet dui accumsan.\n \n [b]Improvements[/b]\n • Enhanced volutpat commodo sed egestas egestas fringilla.\n • Reduced latency in at auctor urna nunc id cursus.\n \n [b]Fixes[/b]\n • Resolved issue causing rhoncus dolor purus non enim.\n • Fixed rare crash related to dictum fusce ut placerat.\n \n [color=aqua][b]v1.0.0[/b][/color]\n \n [b]Initial Release[/b]\n • Lorem ipsum dolor sit amet.\n • Consectetur adipiscing elit.\n • Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n • Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.\n"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Return.pressed.connect(backButtonPressed)
	$"1_0_0".pressed.connect(displayText.bind("1_0_0"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func backButtonPressed():
	Global.changeScene("MainMenu")

func displayText(id):
	$RichTextLabel.text = historyTextDict[id]
