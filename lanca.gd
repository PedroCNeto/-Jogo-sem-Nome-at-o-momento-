extends Area2D

var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta




func _on_body_entered(body):
	if body is RigidBody2D:
		body.queue_free()

