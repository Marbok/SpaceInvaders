extends Area2D

signal goal(body)

export var speed = 500
var velocity = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Blast_body_entered(body):
	if "Asteroid" in body.name:
		emit_signal("goal", body)
		queue_free()
