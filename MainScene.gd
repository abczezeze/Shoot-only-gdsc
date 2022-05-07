extends Spatial

var ballr = preload("res://ShootBall/Ball.tscn"); var ballrc
var godotToon = preload("res://ObstacleA/GodotToon1.tscn"); var boxCloneA; var boxCloneB

var timeSpawn = 0
var timeMovePathFollow = 0

var cam_translate = 10
var renderSpeed = 5

var mouse_pos = Vector2()
var mouse_sens= 300.0
var mouse_speed = 5

func _ready():
	Global.loadScene("res://MainScene.tscn")
	
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	SilentWolf.Scores.persist_score("abczezeze",85,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("zzzddd",50,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("bczze",35,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("cze",101,"shoot-only-gdsc")

	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	print("All scores: " + str(SilentWolf.Scores.scores))
#	print(SilentWolf.Scores.scores[0].player_name)
#	print(SilentWolf.Scores.scores)

func _process(delta):
#	cam_translate += renderSpeed * delta
#	if $Camera.translation.z >= 2:
#		$Camera.translate(Vector3(0,0,cam_translate))
#		cam_translate -= 1
#	if $Camera.translation.z  <= 2:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	mouse_pos = get_viewport().get_mouse_position()
	$CircleHeart.position = mouse_pos
	
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
	
	if mouse_pos.x > 1260 :
		$Camera.rotate_y(-.05)
	if mouse_pos.x < 20:
		$Camera.rotate_y(.05)
	timeMovePathFollow += delta

	$Path/PathFollow.offset = timeMovePathFollow * -50
	$Path2/PathFollow.offset = timeMovePathFollow * 30

func _physics_process(delta):
	var from = $Camera.project_ray_origin(mouse_pos)
	var to = from + $Camera.project_ray_normal(mouse_pos) * 10
	if Input.is_action_just_pressed("ui_accept") and Global.can_shoot:
		ballrc = ballr.instance()
		ballrc.global_transform.origin = to
		self.add_child(ballrc)
		$Shooting.play()
	
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
#	if Input.is_action_pressed("ui_right"):
#		direction.x += .51
#	if Input.is_action_pressed("ui_left"):
#		direction.x -= .51
#	if Input.is_action_pressed("ui_up"):
#		direction.y -= .51
#	if Input.is_action_pressed("ui_down"):
#		direction.y += .51

	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	var movement = mouse_sens * direction * delta * mouse_speed

	if movement:
		get_viewport().warp_mouse(mouse_pos+movement)
		
