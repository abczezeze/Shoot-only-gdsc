extends RigidBody

const BASE_BULLET_BOOST = 0.1;
var qf = 0

func _process(delta):
	var direction_vect = global_transform.basis.z.normalized() * BASE_BULLET_BOOST;

	qf += delta
	if qf >= 5:
		queue_free()
