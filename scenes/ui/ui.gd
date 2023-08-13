extends CanvasLayer

@onready var item_bar: HBoxContainer = %ItemBar

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")

const highlight_texture = preload("res://assets/ui/kenney_ui-pack-rpg-expansion/PNG/buttonSquare_beige_pressed.png")

func _ready():
  for i in range(inventory_manager.MAX_WEAPON_COUNT):
    var item = draw_item(null)
    item_bar.add_child(item)

  inventory_manager.inventory_updated.connect(_redraw_item_bar)
  inventory_manager.current_weapon_updated.connect(current_weapon_updated)

func _process(_delta):
  var boxes = item_bar.get_children()

  for i in range(boxes.size()):
    var box = boxes[i]
    var weapon = inventory_manager.weapons[i]

    if weapon != null:
      box.get_child(2).max_value = weapon.durability
      box.get_child(2).value = weapon.current_durability

func _redraw_item_bar(weapons: Array):
  var boxes = item_bar.get_children()

  for i in range(boxes.size()):
    var box = boxes[i]
    var weapon = weapons[i]

    if weapon != null:
      box.get_child(1).texture = weapon.get_node("Sprite").texture
    else:
      box.get_child(1).texture = null
      box.get_child(2).value = 0

func draw_item(weapon: Weapon) -> Control:
  var item = Control.new()
  item.set_custom_minimum_size(Vector2(128, 128))

  var texture = TextureRect.new()
  texture.set_expand_mode(TextureRect.EXPAND_FIT_HEIGHT)
  texture.set_anchors_preset(Control.PRESET_FULL_RECT)
  texture.set_texture(weapon.get_node("Sprite").texture if weapon != null else null)

  var highlight = Panel.new()
  highlight.set_anchors_preset(Control.PRESET_FULL_RECT)
  highlight.set_visible(false)

  var health_bar = ProgressBar.new()
  health_bar.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
  health_bar.show_percentage = false

  item.add_child(highlight)
  item.add_child(texture)
  item.add_child(health_bar)

  return item

func current_weapon_updated(_weapon: Weapon):

  for box in item_bar.get_children():
    box.get_child(0).set_visible(false)

  var box = item_bar.get_child(inventory_manager.current_weapon_index)

  box.get_child(0).set_visible(true)
