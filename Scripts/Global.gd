extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass







func changeScene(sceneName):
	match sceneName:
		"MainMenu":
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		"Continue":
			get_tree().change_scene_to_file("res://Scenes/SaveGame.tscn")
