extends Area2D

# Signals to player
signal interact_area_reached
signal interact_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = null
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if InputMap.has_action("interact") and Input.is_action_just_pressed("interact"):
		door_interacted()

# ========== Internal Function ==========
# Self properties
@export var npc_name = "NPC"
@export var dialogue_text = "Dialogue text"
@export var door_image: Texture2D

# Internal variable
var player
var player_movable = true

# Detect player presence
func _on_interact_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		set_process(true)
		interact_area_reached.emit(true)

func _on_interact_collision_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
		set_process(false)
		interact_area_reached.emit(false)


func door_interacted():
	interact_button_pressed.emit([npc_name, dialogue_text, door_image])
	if player_movable:
		player_movable = false
		player.set_physics_process(false)
	else:
		player_movable = true
		player.set_physics_process(true)
