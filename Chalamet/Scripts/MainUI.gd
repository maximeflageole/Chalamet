class_name MainUI

extends Control

@export var gm : GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnBtnClicked(btn:ConstructButton):
	gm.OnButtonPressed()


