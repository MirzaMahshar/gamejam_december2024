@tool

extends StaticBody2D

# Signals to player
signal interact_area_reached
signal interact_button_pressed

enum InteractiveObject { DRAWING, RAINBOW, MAILBOX, BOOK}
@export var item : InteractiveObject

# Internal variable
var player
var player_movable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if InputMap.has_action("interact") and Input.is_action_just_pressed("interact"):
		push_warning("Interact button pressed")
		interact_button_pressed.emit()
		if player_movable:
			player_movable = false
			player.set_physics_process(false)
		else:
			player_movable = true
			player.set_physics_process(true)


#func _on_body_entered(body):
	#if body.name == "Player":
##		Signal player to interact
		#pass

# Detect player presence
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		set_process(true)
		interact_area_reached.emit()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
		set_process(false)
