extends Node

var Username: String = "USER"

var Compass = true

var PlayerHasTutorialKey = false
var TutorialComplete = false

var Lore1 = 0
var lore2 = 0
var lore7 = 0
var lore8 = 0
var lore9 = 0
var lore10 = 0
#Keeping track of which collectibles the player has found.

var shadows = true

var InputType = 2
# 1 = manual control
# 2 = auto control



var PlayerControls = true
#disable or enable player controls

var InDialogue = false
#used to disable player controls during dialogue

var paused = false
#to tell if game is paused or not.

var CutScene1Anim = 0

var CutScene1Finished = 0

var PlayerSupplies: int = 0
#number of supplies the player has in SupplyCountScript

var supplies1 = 0
#max is 1

var supplies2 = 0
#max is 3

var StoryStage: int = 0
#determines state of the game's story
#1 wake up.
#2 eat
#3 incoming message
#4 select destination
#5 search for supplies 1
#6 first location done.
#7 second location done.
#8 To Avalon
#9 End of demo

var NaomiMessages: int = 0

var HallwayLoop = 0
var HallwayPos = null

var NaomiShip1 = false
var NaomiShip2 = false
var NaomiOnShip = false

var CamText: String = "Ship Cam"

var radio_freq: int = 000

var ShipMenu = false

var Destination = 0
# Destination 1 is Abandoned Ship
# Destination 2 is Brimpie Orbital
# Destination 3 is Next Level

var Suit = false

var VisitedShip = 0
var VisitedStation = 0

var KeysFound = 0

const TIMER_LIMIT = 2.0
var timer = 0.0

#func _process(delta):
	#timer
	#timer += delta
	#if timer > TIMER_LIMIT: # Prints every 2 seconds
		#timer = 0.0
		#print("fps: " + str(Engine.get_frames_per_second()))
#
	#if Input.is_action_just_pressed("Debug"):
		#print("Stage is: ", StoryStage)
		#print("Destination is: ", SceneSwitcher.Destination)
#
	#if Input.is_action_pressed("Ctrl") and Input.is_action_pressed("L_Shift") and Input.is_action_pressed("R_Key"):
		#_restart()

func _restart():
	Lore1 = 0
	lore2 = 0
	lore7 = 0
	lore8 = 0
	lore9 = 0
	lore10 = 0
	PlayerControls = true
	InDialogue = false
	paused = false
	PlayerSupplies = 0
	supplies1 = 0
	supplies2 = 0
	StoryStage = 0
	NaomiMessages = 0
	HallwayLoop = 0
	NaomiShip1 = false
	NaomiShip2 = false
	NaomiOnShip = false
	CamText = "Ship Cam"
	radio_freq = 000
	Destination = 0
	Suit = false
	VisitedShip = 0
	VisitedStation = 0
	KeysFound = 0
	CutScene1Anim = 0
	CutScene1Finished = 0
	SceneSwitcher.Destination = 0
	SceneSwitcher.PlayerShipSpawn = null
	SceneSwitcher.PlayerSpawn = null
