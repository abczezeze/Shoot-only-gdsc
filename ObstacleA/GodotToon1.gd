extends RigidBody

const BASE_BULLET_BOOST = 0.1;
var qf = 0
var ro_y_speed = 10
	
func _physics_process(delta):
	$Plane.rotate_y(ro_y_speed * delta)
	var direction_vect = global_transform.basis.z.normalized() * BASE_BULLET_BOOST;

	qf += delta
	if qf >= 5:
		queue_free()

func _on_GodotToon1_body_entered(body):
	if body.is_in_group("ShootBall"):
		self.gravity_scale = -1
		$CPUParticles.show()

