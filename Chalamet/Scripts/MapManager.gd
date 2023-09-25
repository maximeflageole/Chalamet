class_name MapManager
extends Node3D

@export var dimensions : Vector2i

var _allTiles: Array[FloorTile]
var _currentSelectedTile : FloorTile

func _ready():
	var tilePrefab = preload("res://Prefabs/floor_tile.tscn")
	for i in range(dimensions.x):
		for j in range(dimensions.y):
			var newTile = tilePrefab.instantiate()
			add_child(newTile)
			_allTiles.append(newTile)
			newTile.OnTileHovered.connect(SetCurrentTile)
			newTile.global_position = Vector3(-50+i*5.1,0.2,-50+j*5.1)
			newTile.SetCoordinates(i, j)

func CanPlaceBuilding() -> bool:
	return not _currentSelectedTile.m_isOccupied
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func SetCurrentTile(floorTile: FloorTile):
	if (not floorTile.m_isOccupied):
		_currentSelectedTile = floorTile

func GetCurrentTile() -> FloorTile:
	return _currentSelectedTile
