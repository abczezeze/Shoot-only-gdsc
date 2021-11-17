extends Spatial

var ballr = preload("res://ShootBall/Ball.tscn")
var ballrc
var boxr = preload("res://ObstacleA/Box.tscn")
var boxClone
var boxGuided = preload("res://Guided/Guided.tscn")
var boxGuidedClone
var timeSpawn = 0
var clicks = 0
onready var spawnSpeed = 0.1
onready var camera = $Camera

func _ready():
#	SilentWolf.Scores.persist_score("abczezeze",85,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("zzzddd",50,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("bczze",35,"shoot-only-gdsc")
#	SilentWolf.Scores.persist_score("cze",21,"shoot-only-gdsc")

	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
#	print("All scores: " + str(SilentWolf.Scores.scores))
#	print(SilentWolf.Scores.scores[0].player_name)
	print(SilentWolf.Scores.scores)
#	print(SilentWolf.Scores.scores.size())

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()
		
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 10
	
	boxGuidedClone = boxGuided.instance();
	boxGuidedClone.global_transform.origin = to
	add_child(boxGuidedClone)
#	$MeshSpawn.global_translate(Vector3(spawnSpeed,sin($MeshSpawn.transform.origin.x),0))
	$MeshSpawn.global_translate(Vector3(spawnSpeed,0,0))
	boxClone = boxr.instance()
	boxClone.global_transform.origin = $MeshSpawn.transform.origin
	timeSpawn += delta
	if timeSpawn > 1:
		self.add_child(boxClone)
		timeSpawn = 0
		
#	print($MeshSpawn.transform.origin.x)
	if $MeshSpawn.transform.origin.x >= 30:
#		print("plus")
		spawnSpeed *= -1
	if $MeshSpawn.transform.origin.x <= -30:
#		print("minus")
		spawnSpeed *= -1
	$VContianer/HBoxContainer/hitNumber.set_text(str(Global.hitBall))

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 10
		ballrc = ballr.instance()
		ballrc.global_transform.origin = to
#		print("cam_orig:",camera.project_ray_origin(event.position))
#		print("cam_nm  :",camera.project_ray_normal(event.position))
#		print("to :",to)
#		balli.set_name("ballc")
		self.add_child(ballrc)
		clicks+=1
		$VContianer/MClickNumber.set_text(str("Clicks=",clicks))
		$Shooting.play()
		
