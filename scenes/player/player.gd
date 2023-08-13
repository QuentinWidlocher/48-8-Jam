class_name Player
extends CharacterBody2D

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")
@onready var level_manager: LevelManager = get_node("/root/LevelManager")
@onready var player_manager: PlayerManager = get_node("/root/PlayerManager")

@onready var debug_label: Label = $Label
@onready var weapon_location: Node2D = $WeaponAnchor/WeaponLocation
@onready var weapon_anchor: Node2D = $WeaponAnchor
@onready var dispenser_area_2d: Area2D = $DispenserArea2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D 

var max_health = 100
var health = max_health
var state: State
var looking_angle := 0.0
var near_dispenser: Dispenser

func _ready():
  state = IdleState.new(self)
  state.on_enter()

  player_manager.health_updated.emit(health, max_health)

  inventory_manager.current_weapon_updated.connect(current_weapon_updated)
  inventory_manager.inventory_updated.connect(weapons_updated)

func _physics_process(delta):
  if not state:
    return

  near_dispenser = null
  for area in dispenser_area_2d.get_overlapping_areas():
    var dispenser = area.get_parent()
    if dispenser is Dispenser:
      near_dispenser = dispenser
  
  weapon_anchor.rotation = Vector2.RIGHT.rotated(looking_angle).angle()

  var new_state = state.update(delta)

  if state != new_state:
    var previous_name = state.name
    state.on_exit()
    state = new_state
    state.on_enter()
    debug_label.text = state.name
    print("-> " + state.name + " from " + previous_name)

  move_and_slide()

func handle_common_collision():
  pass

func switch_weapon(previous_weapon: Weapon, new_weapon: Weapon):
  weapon_location.remove_child(previous_weapon)
  weapon_location.add_child(new_weapon)

func break_current_weapon():
  inventory_manager.current_weapon = null

func get_current_weapon():
  return inventory_manager.current_weapon

func weapons_updated(weapons: Array):
  for i in range( weapons.size() ):
    var weapon = weapons[i]
    var child = weapon_location.get_child(i)

    if weapon != null:
      if child == null:
        weapon_location.add_child(weapon)
    else:
      if child != null:
        weapon_location.remove_child(child)
    

func current_weapon_updated(weapon: Weapon):
  var current_weapon_in_hand = weapon_location.get_child(0) if weapon_location.get_child_count() > 0 else null

  for i in range(weapon_location.get_child_count()):
    var weapon_in_hand = weapon_location.get_child(i)

    print("comparing " + weapon_in_hand.name + " with " + (str(weapon.name) if weapon != null else "null"))

    if weapon != null and weapon == weapon_in_hand:
      weapon_in_hand.set_process(true)
      weapon_in_hand.sprite.visible = true
    else:
      weapon_in_hand.set_process(false)
      weapon_in_hand.sprite.visible = false

func take_damage(damage: float):
  health -= damage
  player_manager.health_updated.emit(health)

  if health <= 0:
    level_manager.player_died()
