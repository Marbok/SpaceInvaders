extends Node

export (PackedScene) var Asteroid
export (PackedScene) var Blast
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$HUD/Message.hide()
	new_game()

func _process(delta):
	$HUD.update_score(score)
	
func game_over():
	$HUD.game_over()
	$AsteroidTimer.stop()
	$ScoreTimer.stop()
	get_tree().call_group("asteroids", "queue_free")
	
func new_game():
	$AsteroidTimer.start()
	$ScoreTimer.start()
	$SpaceShip.start($StartPosition.position)
	score = 0

func _on_AsteroidTimer_timeout():
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	var asteroid = Asteroid.instance()
	add_child(asteroid)
	var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	asteroid.position = $AsteroidPath/AsteroidSpawnLocation.position
	asteroid.rotation = direction
	asteroid.linear_velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = asteroid.linear_velocity.rotated(direction)


func _on_SpaceShip_fire():
	var blast = Blast.instance()
	add_child(blast)
	blast.rotation = $SpaceShip.rotation
	blast.velocity = Vector2(0, -blast.speed).rotated($SpaceShip.rotation)
	blast.position = $SpaceShip.position
	blast.connect("goal", self, "handle_goal")

func handle_goal(body):
	score += 10
	body.queue_free()

func _on_SpaceShip_hit():
	game_over()

func _on_ScoreTimer_timeout():
	score += 1