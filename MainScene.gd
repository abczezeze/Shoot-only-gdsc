extends Spatial

var ballr = preload("res://ShootBall/Ball.tscn")
var ballrc
var boxr = preload("res://ObstacleA/Box.tscn")
var godotToon = preload("res://ObstacleA/GodotToon1.tscn")
var boxCloneA
var boxCloneB
var timeSpawn = 0
var timeMovePathFollow = 0
var mouse_pos = Vector2()

#func _ready():
#	SilentWolf.Scores.persist_score("abczezeze",85,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("zzzddd",50,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("bczze",35,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("cze",21,"shoot-only-gdsc")

#	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
#	print("All scores: " + str(SilentWolf.Scores.scores))
#	print(SilentWolf.Scores.scores[0].player_name)
#	print(SilentWolf.Scores.scores)
#	print(SilentWolf.Scores.scores.size())

func _process(delta):
	if Input.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()
		
	mouse_pos = get_viewport().get_mouse_position()
	
	boxCloneA = boxr.instance()
	boxCloneB = godotToon.instance()
	boxCloneA.transform = $Path/PathFollow.transform
	boxCloneB.transform = $Path2/PathFollow.transform
	timeSpawn += delta
	if timeSpawn > .5:
		self.add_child(boxCloneA)
		self.add_child(boxCloneB)
		timeSpawn = 0
	$HBoxContainer/hitNumber.set_text(str(Global.hitBall))
	$Label.text = str(mouse_pos)
	if mouse_pos.x > 1260 :
		$Camera.rotate_y(-.05)
	if mouse_pos.x < 20:
		$Camera.rotate_y(.05)
	timeMovePathFollow += delta

	$Path/PathFollow.offset = timeMovePathFollow * -20 
	$Path2/PathFollow.offset = timeMovePathFollow * 20 
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = $Camera.project_ray_origin(event.position)
		var to = from + $Camera.project_ray_normal(event.position) * 10
		ballrc = ballr.instance()
		ballrc.global_transform.origin = to

		self.add_child(ballrc)
		$Shooting.play()
	if InputEventMouseMotion:
		$CircleHeart.position = mouse_pos
	
