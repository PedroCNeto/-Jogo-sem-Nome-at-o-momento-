extends Area2D
signal pegouMoeda
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.set_deferred("visible", false)
		$MoedaTimerRespawn.start()
		pegouMoeda.emit()

func _on_moeda_timer_respawn_timeout():
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.set_deferred("visible", true)
