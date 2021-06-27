extends RigidBody2D

export var min_speed = 150
export var max_speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bounce(1)
	set_friction(0)
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0
