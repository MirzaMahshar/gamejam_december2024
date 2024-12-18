extends CanvasLayer

var held_object = null
var visible_active = false

signal defend_strategy
signal attack_strategy
signal packed_signal

# Pattern
var defend = [
	1, 1, 1,
	1, 0, 1,
	1, 1, 1
]
var attack = [
	1, 0, 1,
	0, 1, 0,
	1, 0, 1
]

var strategy = []

func get_grid():
	for grid in get_tree().get_nodes_in_group("GridBox"):
		if grid.occupied == true:
			strategy.append(1)
		elif grid.occupied == false:
			strategy.append(0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("GridBox"):
		node.grid_update.connect(_on_grid_box_grid_update)
	hide()
	#pass

# Assemble to weapon
func _process(delta: float) -> void:
	pass


func _on_cloud_clicked(object) -> void:
	#print("Clickeddddd")
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func activate():
	if visible_active:
		print("Cloudshaper Disable")
		hide()
		visible_active = false
	else:
		print("Cloudshaper Active")
		show()
		visible_active = true

func execute_strategy(strategy):
	if strategy == "Defend":
		$Background/Strategy.text = "Defend!"
		packed_signal.emit("execute_cloudshaper", [strategy])
	elif strategy == "Attack":
		$Background/Strategy.text = "Attack!"
		packed_signal.emit("execute_cloudshaper", [strategy])
	else:
		$Background/Strategy.text = ""
		packed_signal.emit("execute_cloudshaper", [strategy])

func _on_grid_box_grid_update() -> void:
	strategy.clear()
	get_grid()
	if strategy.hash() == defend.hash():
		execute_strategy("Defend")
		defend_strategy.emit()
	elif strategy.hash() == attack.hash():
		execute_strategy("Attack")
		attack_strategy.emit()
	else:
		execute_strategy("")
