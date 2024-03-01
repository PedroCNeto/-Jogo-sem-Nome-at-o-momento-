extends Node2D
@export var mob_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$Mobtimer.start()
	$CharacterBody2D/Camera2D.align()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for index in $CharacterBody2D.get_slide_collision_count():
		var collision = $CharacterBody2D.get_slide_collision(index)
		var body = collision.get_collider()
		if body is RigidBody2D:
			get_tree().quit()



func _on_mobtimer_timeout():
	print("maluvoswiky")

	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $Path2D/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation - PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(PI / 4, -PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	if $Mobtimer.wait_time > 0.01:
		print($Mobtimer.wait_time)
		$Mobtimer.wait_time = $Mobtimer.wait_time - ($Mobtimer.wait_time * 0.01)
