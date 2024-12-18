extends Area2D

var occupied = false
var unoccupied_colour = Color(0, 0, 0, 0.5)
var occupied_colour = Color(255 ,215, 0, 0.5)

signal grid_update

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#return
	if occupied:
		$Background.color = occupied_colour
	else:
		$Background.color = unoccupied_colour

func _on_body_entered(body: Node2D) -> void:
	if occupied:
		return

	if body.is_in_group("Cloud"):
		var snap_grid = self.position
		body.position = snap_grid
		occupied = true
		grid_update.emit()



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Cloud"):
		occupied = false
		grid_update.emit()
