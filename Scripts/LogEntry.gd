extends Control

func setText(textArr : Array):
	updateSize(textArr.size())
	var fullText = ""
	for line in textArr:
		fullText = fullText + line + "\n"
	$Text.text = fullText

func setTitle(title):
	$Title.text = "[center]"+title

func updateSize(lines):
	self.custom_minimum_size.y = 23 * lines
