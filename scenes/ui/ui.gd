extends CanvasLayer

@onready var item_bar: HBoxContainer = $ItemBar

@onready var inventory_manager: InventoryManager = get_node("/root/MyInventoryManager")

const highlight_texture = preload("res://icon.svg")

func _ready():
  for i in range(inventory_manager.MAX_WEAPON_COUNT):
    var item = draw_item(null)
    item_bar.add_child(item)

  inventory_manager.inventory_updated.connect(_redraw_item_bar)
  inventory_manager.current_weapon_updated.connect(current_weapon_updated)

func _redraw_item_bar(weapons: Array):
  print("Redrawing item bar with ", weapons)
  var boxes = item_bar.get_children()

  for i in range(boxes.size()):
    var box = boxes[i]
    var weapon = weapons[i]

    if weapon != null:
      box.get_child(1).texture = weapon.get_node("Sprite").texture
    else:
      box.get_child(1).texture = null

func draw_item(weapon: Weapon) -> Control:
  var item = Control.new()
  item.set_custom_minimum_size(Vector2(128, 128))

  var bg = ColorRect.new()
  bg.color = Color(0, 0, 0, 0.5)
  bg.set_custom_minimum_size(Vector2(128, 128))

  var texture = TextureRect.new()
  texture.set_texture(weapon.get_node("Sprite").texture if weapon != null else null)

  var highlight = TextureRect.new()
  highlight.name = "Highlight"
  highlight.set_texture(highlight_texture)
  highlight.flip_v = true
  highlight.set_visible(false)

  item.add_child(bg)
  item.add_child(texture)
  item.add_child(highlight)

  return item

func current_weapon_updated(_weapon: Weapon):

  for box in item_bar.get_children():
    box.get_child(2).set_visible(false)

  var box = item_bar.get_child(inventory_manager.current_weapon_index)

  box.get_child(2).set_visible(true)
