extends TouchScreenButton


# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = get_viewport_rect().size.y - 160


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
