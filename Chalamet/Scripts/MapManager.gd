class_name MapManager
extends Node3D

@export var dimensions : Vector2i

var _allTiles: Array[Array]
var _currentSelectedTile : FloorTile

func _ready():
	#TODO MF: Create your own class for 2d Arrays, because this is NASTY
	var tilePrefab = preload("res://Prefabs/floor_tile.tscn")
	_allTiles.resize(dimensions.x)
	for i in range(dimensions.x):
		_allTiles[i].resize(dimensions.y)
		for j in range(dimensions.y):
			var newTile = tilePrefab.instantiate()
			add_child(newTile)
			_allTiles[i][j] = newTile
			newTile.OnTileHovered.connect(SetCurrentTile)
			newTile.global_position = Vector3(-50+i*5.1,0.2,50-j*5.1)
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
	
func PlaceBuilding(building: Building):
	#TODO MF: Clean this
	var occupiedSpace = building._buildingData.OccupiedSpace
	var root = sqrt(occupiedSpace.size())
	for i in range(root):
		for j in range(root):
			if occupiedSpace[i*root + j]:
				var realI = _currentSelectedTile.m_coordinates.x + i
				var realJ = _currentSelectedTile.m_coordinates.y + j
				_allTiles[realI][realJ].PlaceBuilding(building)
	pass
