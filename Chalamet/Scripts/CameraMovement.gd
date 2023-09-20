extends Camera3D

@export var speed : float
@export var shift_speed : float
var is_shifted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	is_shifted = Input.is_action_pressed("Accelerate")
	var x = speed * delta * (1 + (shift_speed * (float)(is_shifted)))
	if Input.is_action_pressed("MoveUp"):
		# Move as long as the key/button is pressed.
		translate(Vector3(0, x, 0))
	if Input.is_action_pressed("MoveDown"):
		translate(Vector3(0, -x, 0))
	if Input.is_action_pressed("MoveLeft"):
		translate(Vector3(-x, 0, 0))
	if Input.is_action_pressed("MoveRight"):
		translate(Vector3(x, 0, 0))
