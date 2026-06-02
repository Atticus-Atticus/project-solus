extends Node2D
#
#@onready var anim: AnimationPlayer = $"../Camera2D/Panel/AnimationPlayer"
#@onready var info_label: Label = $"../Camera2D/Panel/Label"
#
#var default_text := """
			  #INFO PANEL
#
#
#Move ship over a planetary body.
#"""
#
#var planet_info := {
	#"Planet1": """
			  #INFO PANEL
#
#
#PLANET: Brimpie - 1
#
#
#SYSTEM: Brimpie
#
#CLASSIFICATION: Barren Planet
#
#POPULATION: 250,000 [estimate]
#
#PURPOSE:
#Power Generation and Distribution
#
#ATMOSPHERE: Contamination Detected
#
#GRAVITY: 0.6 G
#
#TEMPERATURE: 155°C
#
#LANDING CLEARANCE: ERROR
#""",
#
		#"Planet2": """
			  #INFO PANEL
#
#
#PLANET: Brimpie - 2
#
#
#SYSTEM: Brimpie
#
#CLASSIFICATION: Rocky Body (Terraformed to Earth-Like)
#
#POPULATION: 100.4 Million [estimate]
#
#PURPOSE:
#Wheat Agriculture and Synthetic Protein Production
#
#ATMOSPHERE: Contamination Detected
#
#GRAVITY: 0.8 G
#
#TEMPERATURE: 20°C
#
#LANDING CLEARANCE: ERROR
#""",
#
	#"Planet3": """
			  #INFO PANEL
#
#
#PLANET: Brimpie - 3
#
#
#SYSTEM: Brimpie
#
#CLASSIFICATION: Earth-Like Planet
#
#POPULATION: 1.2 billion [estimate]
#
#PURPOSE:
#Wheat and Algea Agriculture and Residential
#
#ATMOSPHERE: Contamination Detected
#
#GRAVITY: 1.2 G
#
#TEMPERATURE: 16°C
#
#LANDING CLEARANCE: ERROR
#""",
	#"Planet4": """
			  #INFO PANEL
#
#
#PLANET: Brimpie - 4
#
#
#SYSTEM: Brimpie
#
#CLASSIFICATION: Class-2 Gas Giant
#
#POPULATION: 14,500 [estimate]
#
#PURPOSE:
#Long Range Communications and System Wide Monitoring
#
#ATMOSPHERE: Contamination Detected
#
#GRAVITY: 2.9 G
#
#TEMPERATURE: -195°C
#
#LANDING CLEARANCE: ERROR
#""",
	#"Planet5": """
			  #INFO PANEL
#
#
#PLANET: Brimpie - 5
#
#
#SYSTEM: Brimpie
#
#CLASSIFICATION: Metal Rich Rocky Body
#
#POPULATION: N/A
#
#PURPOSE:
#Mining and Mineral Processing
#
#ATMOSPHERE: Contamination Detected
#
#GRAVITY: 0.8 G
#
#TEMPERATURE: 278°C
#
#LANDING CLEARANCE: RESTRICTED
#
#NOTE: Planet destroyed in mining accident. Travel is prohibited.
#"""
#}
#
#
#func _ready() -> void:
	#info_label.text = default_text
#
	#for child in get_children():
		#if child is Area2D:
			#child.body_entered.connect(_on_planet_body_entered.bind(child))
			#child.body_exited.connect(_on_planet_body_exited.bind(child))
#
#
#func _on_planet_body_entered(body: Node2D, planet_area: Area2D) -> void:
	#if body is CharacterBody2D:
		#anim.play("open")
#
		#var planet_name := planet_area.name
		#info_label.text = planet_info.get(planet_name, "              INFO PANEL\n\nNo database entry found.")
#
#
#func _on_planet_body_exited(body: Node2D, planet_area: Area2D) -> void:
	#if body is CharacterBody2D:
		#anim.play_backwards("open")
		#info_label.text = default_text
