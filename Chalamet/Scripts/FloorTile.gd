class_name FloorTile

extends Area3D

signal OnTileHovered(floorTile: FloorTile)

var Coordinates : Vector2i = Vector2i(-1, -1)

func SetCoordinates(x : int, y: int):
	Coordinates.x = x
	Coordinates.y = y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered() -> void:
	print("On mouse entered \n" + str(Coordinates.x) + ", " + str(Coordinates.y))
	OnTileHovered.emit(self)

func _on_mouse_exited():
	pass
