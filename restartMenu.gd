extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "Your points: " + str(Points.points) 


func _on_menu_btn_pressed():
	var mainMenu = load("res://Mainmenu.tscn")
	get_tree().change_scene_to_packed(mainMenu)
	Points.points = 0
	Points.lancaState = true

func _on_restart_btn_pressed():
	var mainGame = load("res://Maingame.tscn")
	get_tree().change_scene_to_packed(mainGame)
	Points.points = 0
