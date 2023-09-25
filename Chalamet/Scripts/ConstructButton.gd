class_name ConstructButton

extends Button

@export var mainUI : MainUI
@export var m_buildingToBuild: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	self.pressed.connect(self._button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed():
	mainUI.OnBtnClicked(self)
