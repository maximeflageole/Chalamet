class_name GameManager
extends Node3D

@export var myInt = 5
@export var mainUI : MainUI
@export var buildingsData : Array[BuildingData]
@export var _mapManager : MapManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnButtonPressed(btn: ConstructButton):
	var buildingPrefab = load(btn.m_buildingToBuild)
	var building = buildingPrefab.instantiate()
	building._GM = self
	add_child(building)
	
func GetCurrentTile() -> FloorTile:
	return _mapManager.GetCurrentTile()

func CanPlaceBuilding() -> bool:
	return _mapManager.CanPlaceBuilding()
	
func OnBuildingPlaced(building: Building):
	_mapManager.GetCurrentTile().PlaceBuilding(building)
	_mapManager.GetCurrentTile().m_objectPlaced = building
	pass
