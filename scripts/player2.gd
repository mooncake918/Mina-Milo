extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = -300.0
@export var gravity: float = 800.0

var wall_direction: int = 0  # -1 = left wall, 1 = right wall

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const PUSH_FORCE = 50
const MAX_VELOCITY = 150

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction: -1, 0, 1
	var direction := Input.get_axis("move_left2", "move_right2")
	
	# Flip direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_crate = collision.get_collider()
		if collision_crate.is_in_group("Crates") and abs(collision_crate.get_linear_velocity().x) < MAX_VELOCITY:
			collision_crate.apply_central_impulse(collision.get_normal()*-PUSH_FORCE)

	move_and_slide()

func test_wall_collision() -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(velocity.x * 0.1, 0), 1)
	var result = space_state.intersect_ray(query)
	return result.size() > 0
