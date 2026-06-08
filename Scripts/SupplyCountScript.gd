extends StaticBody3D


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
