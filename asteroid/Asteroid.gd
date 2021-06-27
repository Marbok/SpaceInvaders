extends RigidBody2D

export var min_speed = 150
export var max_speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bounce(1)
	set_friction(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
