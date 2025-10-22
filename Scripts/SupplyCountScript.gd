extends StaticBody3D

@onready var text_scene1: PackedScene = preload("res://Scenes/User Interface/Dialogue/PlayerSupplyDialogueBox.tscn")
#@onready var text_scene2: PackedScene = preload("res://Scenes/User Interface/Dialogue/PlayerNoSupplyDialogueBox.tscn") UNUSED!
@onready var eat_text: PackedScene = preload("res://Scenes/User Interface/Dialogue/EatSomethingDialogueBox.tscn")

func _process(delta: float) -> void:
	if Globals.PlayerSupplies == 0:
		$SuppliesEmtpy.set_visible(true)
		$SuppliesLow.set_visible(false)
		$SuppliesMid.set_visible(false)
		$SuppliesHigh.set_visible(false)
		
	if Globals.PlayerSupplies >= 1 && Globals.PlayerSupplies <= 30:
		$SuppliesEmtpy.set_visible(false)
		$SuppliesLow.set_visible(true)
		$SuppliesMid.set_visible(false)
		$SuppliesHigh.set_visible(false)
			
	if Globals.PlayerSupplies >= 31 && Globals.PlayerSupplies <= 70:
		$SuppliesEmtpy.set_visible(false)
		$SuppliesLow.set_visible(false)
		$SuppliesMid.set_visible(true)
		$SuppliesHigh.set_visible(false)
			
	if Globals.PlayerSupplies >= 71 && Globals.PlayerSupplies <= 100:
		$SuppliesEmtpy.set_visible(false)
		$SuppliesLow.set_visible(false)
		$SuppliesMid.set_visible(false)
		$SuppliesHigh.set_visible(true)

func interact():
	if Globals.PlayerSupplies == 0 && Globals.StoryStage == 2:
		var text_temp3 = eat_text.instantiate()
		add_child(text_temp3)
		Globals.StoryStage += 1
	else:
		var text_temp1 = text_scene1.instantiate()
		add_child(text_temp1)
