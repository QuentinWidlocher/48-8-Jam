class_name Mob
extends CharacterBody2D

@export var damage = 10.0
@export var max_health = 20.0
@export var invincibility_timeout = 0.5

@onready var health_bar: ProgressBar = $ProgressBar

var current_health = max_health
var current_invincibility_timeout = 0.0

var can_be_hurt: bool:
  get:
    return current_invincibility_timeout <= 0.0

func _ready():
  get_node("AnimatedSprite2D").play("default")
  health_bar.max_value = max_health

func _process(delta):
  if current_invincibility_timeout > 0:
    current_invincibility_timeout -= delta

func _on_hit_area_2d_area_entered(area):
  print( "_on_hit_area_2d_area_entered" )
  if not can_be_hurt:
    return

  if area is MeleeWeapon:
    var weapon: MeleeWeapon = area
    current_health -= weapon.damage
    health_bar.value = current_health

  if current_health <= 0:
    queue_free()

func _on_damage_area_2d_body_entered(body):
  print("_on_damage_area_2d_body_entered")
  if body is Player:
    (body as Player).take_damage(damage, self)

