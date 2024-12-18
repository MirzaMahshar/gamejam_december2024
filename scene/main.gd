extends Node

# From main menu, load first scene
func _ready():
#	Connecting every signal from each nodes
	var cloud_shaper_node = get_node("CloudShaper")
	cloud_shaper_node.packed_signal.connect(signal_handler)
	
	var start_scene = load("res://scene/town_hall.tscn")
	var start_node = start_scene.instantiate()
	start_node.packed_signal.connect(signal_handler)
	start_node.debug_signal.connect(debug_print)
	add_child(start_node)

# Handle cloud shaper
func _process(delta: float) -> void:
	if InputMap.has_action("cloud_shaper") and Input.is_action_just_pressed("cloud_shaper"):
		$CloudShaper.activate()

# Central signal handler, any communication from scenes, gui or stats should use this method. Add more depending on usecase
func signal_handler(type, args):
	print("Signal handler accessed")
	match type:
		"change_level":
			change_level(args[0], args[1])
		"interact_object":
			dialogue_box(args)
		"execute_cloudshaper":
			execute_cloudshaper(args[0])
		
		_:
			printerr("Unidentified signal_handler")
		


# ========== Helper function called from signal_handler ==========

# Level change handler
func change_level(current, target):
#	Clear current level
	var current_scene = get_node(current)
	current_scene.queue_free()
	
#	Add target level
	var target_scene = load(target)
	var target_node = target_scene.instantiate()
	target_node.packed_signal.connect(signal_handler)
	target_node.debug_signal.connect(debug_print)
	call_deferred("add_child", target_node)
	#add_child(target_node)

func dialogue_box(args):
#	Dialogue option
	if args.size() == 3:
		$DialogueBox.activate_dialogue(args[0], args[1], args[2])
#	Description option
	elif args.size() == 2:
		$DialogueBox.activate_description(args[0], args[1])

# Enable cloudshaper effect on player
func execute_cloudshaper(strategy):
	var player_instance = get_tree().get_first_node_in_group("Player")
	player_instance.execute_cloudshaper(strategy)
	
	
func debug_print():
	print("Debug key pressed")
