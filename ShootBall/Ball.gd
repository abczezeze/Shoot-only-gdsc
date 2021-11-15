extends RigidBody

const KILL_TIMER = 10
var timer = 0

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	apply_impulse(Vector3(rand_range(-10,10),rand_range(-10,10),rand_range(-10,10)),Vector3(0,0,-15))
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()

func _on_Ball_body_entered(body):
	Global.hitBall+=1
	$Hit.play()
	
