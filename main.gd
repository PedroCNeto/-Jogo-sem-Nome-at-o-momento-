extends Node2D
@export var mob_scene: PackedScene

var lanca = preload("res://lanca.tscn")

var pontos = 0
var lancaThrow = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Mobtimer.start()
	$CharacterBody2D/Camera2D.align()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD/Score.text = "Pontos: " + str(pontos) 
	
	for index in $CharacterBody2D.get_slide_collision_count():
		var collision = $CharacterBody2D.get_slide_collision(index)	
		var body = collision.get_collider()
		if body is RigidBody2D:
			if get_tree():
				get_tree().reload_current_scene()



func ativarLanca():
	lancaThrow = true

func _on_mobtimer_timeout():


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
		$Mobtimer.wait_time = $Mobtimer.wait_time - ($Mobtimer.wait_time * 0.01)






func _on_game_time_timeout():
	pontos+=1


func _on_moeda_pegou_moeda():
	pontos+=10


func _on_moeda_2_pegou_moeda():
	pontos+=10


func _on_moeda_3_pegou_moeda():
	pontos+=10


func _on_area_2d_body_entered(body):
	if body.name == 'CharacterBody2D':
		if get_tree():
			get_tree().reload_current_scene()


func _on_button_pressed():
	var mainMenu = load("res://Mainmenu.tscn")
	get_tree().change_scene_to_packed(mainMenu)


func _on_character_body_2d_spear_throw():
	if lancaThrow == true:
		lancaThrow = false
		
		var lanca_instance = lanca.instantiate()
		lanca_instance.position = $CharacterBody2D/SpawnLancas.global_position

		get_tree().get_root().add_child(lanca_instance)
		$LancaTimer.start()




func _on_timer_timeout():
	lancaThrow = true
