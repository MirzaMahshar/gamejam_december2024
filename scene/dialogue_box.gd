extends CanvasLayer

var dialogue_box = load("res://sprite/dialogue/dialogue_box2.png")
var description_box = load("res://sprite/dialogue/dialogue_box1.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var displayed = false

func activate_dialogue(npc_name, text, sprite) -> void:
	$DialogueBackground.texture = dialogue_box
	$CharName.text = npc_name
	$DialogueText.text = text
	$CharPicture.texture = sprite
	if displayed:
		hide()
		displayed = false
		return
	else:
		$Beep.play()
		show()
		displayed = true

func activate_description(text, sprite) -> void:
	$DialogueBackground.texture = description_box
	$CharName.text = ""
	$DialogueText.text = text
	$CharPicture.texture = null
	if displayed:
		hide()
		displayed = false
		return
	else:
		$Beep.play()
		show()
		displayed = true
