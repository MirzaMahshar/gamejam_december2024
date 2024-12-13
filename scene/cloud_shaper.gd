extends Node2D

var held_object = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for node in get_tree().get_nodes_in_group("Cloud"):
		#node.clicked.connect(_on_cloud_clicked)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cloud_clicked(object) -> void:
	print("Clickeddddd")
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null
