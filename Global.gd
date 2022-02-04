extends Node

var hitBall = 0
var can_shoot = false
#func _ready():
#	print(SilentWolf.config)
func loadScene(path):
	var loader = ResourceLoader.load_interactive(path)
	
	while true:
		var err = loader.poll()
#		print(err)
		if err == ERR_FILE_EOF:
			break
		if err == OK:
			var progress = float(loader.get_stage()) / loader.get_stage_count()
			print(progress)
#			print(loader.get_stage())
