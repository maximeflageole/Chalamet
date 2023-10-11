class_name GameManager
extends Node3D

@export var myInt = 5
@export var mainUI : MainUI
@export var buildingsData : Array[BuildingData]
@export var _mapManager : MapManager
var _buildingInPlacement : Building

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (_buildingInPlacement == null):
		return
	if Input.is_action_just_pressed("Rotate"):
		_buildingInPlacement.Rotate()
	if Input.is_action_just_pressed("Cancel"):
		_buildingInPlacement.Destroy()
		_buildingInPlacement = null
	pass

func OnButtonPressed(btn: ConstructButton):
	if (_buildingInPlacement != null):
		return
	var buildingPrefab = load(btn.m_buildingToBuild)
	var building = buildingPrefab.instantiate()
	building._GM = self
	_buildingInPlacement = building
	add_child(building)
	
func GetCurrentTile() -> FloorTile:
	return _mapManager.GetCurrentTile()

func CanPlaceBuilding(building: Building) -> bool:
	return _mapManager.CanPlaceBuilding(GetCurrentTile().m_coordinates, building)
	
func OnBuildingPlaced(building: Building):
	_mapManager.PlaceBuilding(building)
	_buildingInPlacement = null
