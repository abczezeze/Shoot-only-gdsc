extends RigidBody

const KILL_TIMER = 10
var timer = 0
var rand_x = rand_range(-10,10)
var rand_y = rand_range(-10,10)
var rand_z = rand_range(-10,10)

func _physics_process(delta):
#	apply_central_impulse(Vector3(0,0,-10))
	apply_impulse(Vector3(), global_transform.origin*5)
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()
		

func _on_Ball_body_entered(body):
	Global.hitBall+=1
	$Hit.play()
	
