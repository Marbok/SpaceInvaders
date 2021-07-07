extends Area2D

signal hit
signal fire

export var max_speed = 400
export var rotation_speed = 1.5
export var acceleration = 1
var screen_size
var current_speed
var blastEnable = true
var active = false

#var left_engine_enable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$FireMax.hide()
	$FireMin.hide()
	current_speed = 0
	screen_size = get_viewport_rect().size

func _process(delta):
	var left_engine_enable = false
	var right_engine_enable = false
	if active:
		if Input.is_action_pressed("ui_up"):
			current_speed += acceleration
		if Input.is_action_pressed("ui_down"):
			current_speed -= acceleration
		if Input.is_action_pressed("ui_right"):
			left_engine_enable = true
			rotation += deg2rad(rotation_speed)
		if Input.is_action_pressed("ui_left"):
			right_engine_enable = true
			rotation -= deg2rad(rotation_speed)
		if Input.is_action_pressed("ui_select"):
			if blastEnable:
				blastEnable = false
				emit_signal("fire")
		current_speed = clamp(current_speed, 0, max_speed)
		position -= Vector2(0, current_speed * delta).rotated(rotation)
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
	handle_animation(left_engine_enable, right_engine_enable)

func handle_animation(left_engine_enable, right_engine_enable):
	if left_engine_enable:
		$FireLeft.show()
	else:
		$FireLeft.hide()
		
	if right_engine_enable:
		$FireRight.show()
	else:
		$FireRight.hide()
	
	if current_speed == 0:
		$FireMax.hide()
		$FireMin.hide()
	elif current_speed < max_speed / 2:
		$FireMax.hide()
		$FireMin.show()
	else:
		$FireMax.show()
		$FireMin.hide()
		

func start(pos):
	position = pos
	current_speed = 0
	rotation = 0
	show()
	$CollisionShape2D.disabled = false
	active = true

func _on_SpaceShip_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	active = false


func _on_BlastTimer_timeout():
	blastEnable = true
