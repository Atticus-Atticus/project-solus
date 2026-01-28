extends Node

var Username: String = "USER"

var Compass = true

var Lore1 = 0
var lore2 = 0
var lore7 = 0
var lore8 = 0
var lore9 = 0
var lore10 = 0
#Keeping track of which collectibles the player has found.

var InputType = 1
#1 used for tank controls (default)
#2 used for mouse directional
#3 used for camera relative movement

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

var HallwayLoop = 0
var HallwayPos = null

var NaomiShip1 = false
var NaomiShip2 = false
var NaomiOnShip = false

var CamText: String = "Ship Cam"

var radio_freq: int = 00.00

var ShipMenu = false

var Destination = 0
# Destination 1 is Abandoned Ship
# Destination 2 is Brimpie Orbital
# Destination 3 is Next Level

var Suit = false

var VisitedShip = 0
var VisitedStation = 0

var KeysFound = 0

func _process(delta: float) -> void:
	pass
