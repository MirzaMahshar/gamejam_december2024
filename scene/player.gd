extends CharacterBody2D

# Node reference
@onready var animation_sprite = $AnimatedSprite2D

@export var speed = 256 # How fast the player will move (pixels/sec).
var tile_size = 128

#direction and animation to be updated throughout game state
var new_direction = Vector2(0,1) #only move one spaces
var animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)
	hide()

# Behaviour when new game starts
func start(pos):
	position = pos
	set_physics_process(true)
	show()
	$CollisionShape2D.disabled = false

# Movement physics
func _physics_process(delta):
	# Get player input (left, right, up/down)
	var direction: Vector2
	direction.x = Input.get_action_strength("move_right") -Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# Sprinting
	if Input.is_action_pressed("sprint"):
		speed = 512
	elif Input.is_action_just_released("sprint"):
		speed = 256
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	# Apply movement
	var movement = speed * direction * delta
	# Moves our player around, whilst enforcing collisions so that they come to a stop when colliding with another object.
	move_and_collide(movement)

	#plays animations
	player_animations(direction)

# Animations
func player_animations(direction : Vector2):
	# If player is moving
	if direction != Vector2.ZERO:
		#update our direction with the new_direction
		new_direction = direction
		#play walk animation because we are moving
		animation = "walk_" + returned_direction(new_direction)
		animation_sprite.play(animation)
	else:
		#play idle animation because we are still
		animation  = "idle"
		animation_sprite.play(animation)

# Animation Direction
func returned_direction(direction : Vector2):
	#it normalizes the direction vector
	var normalized_direction  = direction.normalized()
	var default_return = "down"

	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		return "right"
	elif normalized_direction.x < 0:
		return "left"
	#default value is empty
	return default_return

# Emit interactable speech bubble
func _on_interactive_object_interact_area_reached() -> void:
	push_warning("Interactable object nearby")
