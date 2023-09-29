class_name FloorTile

extends Area3D

signal OnTileHovered(floorTile: FloorTile)

@export var resourceType: GlobalEnums.EResourceType

var m_coordinates : Vector2i = Vector2i(-1, -1)
var m_isOccupied = false
var m_objectPlaced : Building

func SetCoordinates(x : int, y: int):
	m_coordinates.x = x
	m_coordinates.y = y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered() -> void:
	print("On mouse entered \n" + str(m_coordinates.x) + ", " + str(m_coordinates.y))
	OnTileHovered.emit(self)

func _on_mouse_exited():
	pass

func PlaceBuilding(building: Building):
	print("Building placed")
	m_objectPlaced = building
	m_isOccupied = true
	($CollisionShape3D/MeshInstance3D).material_override = load("res://Materials/TileBusyMaterial.tres")
