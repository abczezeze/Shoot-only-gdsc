extends RigidBody

var qf = 0
	
func _physics_process(delta):
	
	qf += delta
	if qf >= 2 :
		queue_free()
		Global.can_shoot = true
