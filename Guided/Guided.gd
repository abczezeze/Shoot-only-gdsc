extends Spatial

const KILL_TIMER = 0.5
var timer = 0

func _physics_process(delta):
#	var forward_dir = global_transform.basis.z.normalized()
#	global_translate(forward_dir * delta * -100)
#	global_translate(global_transform.origin*100)
#	print(forward_dir.z)
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()
