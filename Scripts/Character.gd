extends Node2D

var targetPosition

var centerPos = 960
var leftSide = 543
var rightSide = 1377
var movespeed = 0.2 # 0 - 1. move 0% to 100% of remaining length per frame
var minTimeBetweenMovements = 1.2
var timeSinceMovement : float

var sentSignal : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetPosition = 960
	Global.displayCharacter.connect(changeCharacter)
	Global.moveCharacter.connect(moveCharacter)
	Global.commandComplete.connect(preventDuplicateComplete)
	sentSignal = true
	timeSinceMovement = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeSinceMovement += delta
	lerp_min_step(targetPosition,movespeed,1.0)
	if $Character.position.x == targetPosition and !sentSignal and timeSinceMovement > minTimeBetweenMovements:
		Global.emitSignal("commandComplete","")
		sentSignal = true

func lerp_min_step(target: float, weight: float, min_step: float):
	var currentPos = $Character.position.x
	var next = lerp(currentPos, target, weight)
	var step = next - currentPos

	if abs(step) < min_step and abs(target - currentPos) > min_step:
		next = currentPos + sign(target - currentPos) * min_step

	if abs(target - next) < min_step:
		next = target

	$Character.position.x=next

func changeCharacter(data): # ["PickCharacter", "newCharacter"]
	if !isThisCharacter(data[0]):
		return
	var texture = load(Global.getImage(data[1]))
	$Character.texture = texture

func moveCharacter(data): # ["PickCharacter", "newLocation", "SpeedOfMovement"]
	sentSignal = false
	if !isThisCharacter(data[0]):
		sentSignal = true
		return
	match data[1]:
		"center":
			targetPosition = centerPos
		"left":
			targetPosition = leftSide
		"right":
			targetPosition = rightSide
	movespeed = float(data[2])
	timeSinceMovement = 0

# this function is ran when a complete signal is made so that it does not also send its own signal
func preventDuplicateComplete():
	sentSignal = true

# character commands are sent to all instances. This chooses which one is activated.
func isThisCharacter(name) -> bool: # CharRight / CharLeft
	if self.name == name:
		return true
	else:
		return false
	
