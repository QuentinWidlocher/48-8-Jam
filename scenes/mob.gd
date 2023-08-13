class_name Mob
extends CharacterBody2D

const KNOCKBACK_SPEED = 700
const DECELERATION = 1200.0

@export var damage = 10.0
@export var max_health = 20.0

@onready var health_bar: ProgressBar = $ProgressBar

var current_health = max_health

var can_be_hurt := true

func _ready():
  get_node("AnimatedSprite2D").play("default")
  health_bar.max_value = max_health

func _process(delta):
  if not can_be_hurt:
    self.velocity.x = move_toward(self.velocity.x, 0.0, DECELERATION * delta)
    self.velocity.y = move_toward(self.velocity.y, 0.0, DECELERATION * delta)

    if self.velocity.length() <= 5:
      can_be_hurt = true


func _on_hit_area_2d_area_entered(area):
  if not can_be_hurt:
    return

  if area is MeleeWeapon:
    current_health = current_health - (area as MeleeWeapon).damage
    health_bar.value = current_health
    var direction = self.position - area.position
    self.velocity = direction.normalized() * KNOCKBACK_SPEED
    can_be_hurt = false

  if current_health <= 0:
    queue_free()

func _on_damage_area_2d_body_entered(body):
  print("_on_damage_area_2d_body_entered")
  if body is Player:
    (body as Player).take_damage(damage, self)

