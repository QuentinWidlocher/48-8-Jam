class_name Source
extends Node2D

const MOBS := [
  preload("res://scenes/mobs/bat.tscn"),
]

@export var spawn_timer := 0.0
@export var initial_mob_spawned := 5

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_timer: float

func _ready():
  sprite.play("default")
  current_timer = spawn_timer
  call_deferred("spawn_initial_mobs")

func spawn_initial_mobs():
  for i in range(initial_mob_spawned):
    spawn_mob()

func _process(delta):
  current_timer -= delta

  if current_timer <= 0:
    spawn_mob()
    current_timer = spawn_timer

func spawn_mob():
  var point := get_random_point_in_radius()
  var mob = MOBS[randi() % MOBS.size()].instantiate()
  mob.position = point

  get_parent().add_child(mob)

func get_random_point_in_radius() -> Vector2:
  var angle := randf_range(0, TAU)
  var distance := randf_range(10, 50)
  var point = self.position + polar2cartesian(distance, angle)

  return point

func polar2cartesian(distance: float, angle: float) -> Vector2:
  return Vector2(distance * cos(angle), distance * sin(angle))
