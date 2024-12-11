extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var displayed = false
func _on_interactive_object_interact_button_pressed() -> void:
	if displayed:
		hide()
		displayed = false
		return
	show()
	displayed = true
