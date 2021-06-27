extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartGame.hide()

func update_score(score):
	$Score.text = str(score)

func game_over():
	$Message.text = "Game Over!!!"
	$Message.show()
	$StartGame.show()
	

func _on_StartGame_pressed():
	emit_signal("start_game")
	$StartGame.hide()
	$Message.hide()
