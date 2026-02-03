extends Node

var Destination: int = 0
#0 means no level selected. display interact dialogue with airlock
#1 means change scene to abandoned ship
#2 means change scene to Brimpie Oribtal

@export var PlayerSpawn = null
# 1- if statement checking a return/loading of the hub scene
#1.5 - looad specific PLayer_controls refernce
#2- if un-loading hub scene run function called get_player_pos
#3 -  store that player pos in a gloabal script
#4 have a system that loads and applies playerpos (set_player_pos) when loading the hub scene
#the comments above was from my college tutor. think I'll leave them there.
