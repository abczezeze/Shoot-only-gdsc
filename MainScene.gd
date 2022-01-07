extends Spatial

var ballr = preload("res://ShootBall/Ball.tscn"); var ballrc
var godotToon = preload("res://ObstacleA/GodotToon1.tscn"); var boxCloneA; var boxCloneB
var timeSpawn = 0
var timeMovePathFollow = 0
var mouse_pos = Vector2()
var cam_translate = 10
var renderSpeed = 5

func _ready():
	Global.loadScene("res://MainScene.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	SilentWolf.Scores.persist_score("abczezeze",85,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("zzzddd",50,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("bczze",35,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("cze",21,"shoot-only-gdsc")

	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	print("All scores: " + str(SilentWolf.Scores.scores))
	print(SilentWolf.Scores.scores[0].player_name)
	print(SilentWolf.Scores.scores)
	print(SilentWolf.Scores.scores.size())
	print($MeshMouse.mesh)

func _process(delta):
	cam_translate += renderSpeed * delta
	if $Camera.translation.z >= 2:
		$Camera.translate(Vector3(0,0,cam_translate))
		cam_translate -= 1
#	print($Camera.translation.z)
	if $Camera.translation.z  <= 2:
#		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	mouse_pos = get_viewport().get_mouse_position()
	
	boxCloneA = godotToon.instance()
	boxCloneB = godotToon.instance()
	boxCloneA.transform = $Path/PathFollow.transform
	boxCloneB.transform = $Path2/PathFollow.transform
	timeSpawn += delta
	if timeSpawn > .5:
		self.add_child(boxCloneA)
		self.add_child(boxCloneB)
		timeSpawn = 0
	$HBoxContainer/hitNumber.set_text(str(Global.hitBall))
	
#	if mouse_pos.x > 1260 :
#		$Camera.rotate_y(-.05)
#	if mouse_pos.x < 20:
#		$Camera.rotate_y(.05)
	timeMovePathFollow += delta

	$Path/PathFollow.offset = timeMovePathFollow * -50
	$Path2/PathFollow.offset = timeMovePathFollow * 30
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = $Camera.project_ray_origin(event.position)
		var to = from + $Camera.project_ray_normal(event.position) * 10
		ballrc = ballr.instance()
		ballrc.global_transform.origin = to
		self.add_child(ballrc)
		$Shooting.play()
		
	if InputEventMouseMotion:
		var from = $Camera.project_ray_origin(event.position)
		var to = from + $Camera.project_ray_normal(event.position) * 10
		$MeshMouse.transform.origin = to
		$CircleHeart.position = mouse_pos
	
