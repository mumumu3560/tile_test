extends CharacterBody2D
# ===========================
# プレイヤー.
# ===========================
class_name Cat

# ---------------------------------------
# consts.
# ---------------------------------------
## 移動速度.
const SPEED = 400.0


# ---------------------------------------
# preload.
# ---------------------------------------

# ---------------------------------------
# onready.
# ---------------------------------------
@onready var _spr = $Sprite
@onready var _dir := Vector2.DOWN # 移動方向.

# ---------------------------------------
# vars.
# ---------------------------------------
var _is_moving = false
var _anim_timer = 0

# ---------------------------------------
# public functions.
# ---------------------------------------


# ---------------------------------------
# private functions.
# ---------------------------------------
func _physics_process(delta: float) -> void:
	# 移動処理.
	_update_move(delta)
	# アニメーションの更新.
	_update_anim(delta)

## 更新 > 移動.
func _update_move(delta:float) -> void:
	_is_moving = false
	velocity = Vector2.ZERO
	var dir_horizontal := Input.get_axis("ui_left", "ui_right")
	if dir_horizontal:
		velocity.x = dir_horizontal
		if dir_horizontal < 0:
			_dir = Vector2.LEFT
		else:
			_dir = Vector2.RIGHT
	var dir_vertical := Input.get_axis("ui_up", "ui_down") 
	if dir_vertical:
		velocity.y = dir_vertical
		if dir_vertical < 0:
			_dir = Vector2.UP
		else:
			_dir = Vector2.DOWN
	
	if velocity.is_zero_approx():
		return # 移動なし.
	
	# 正規化して速度と合成する.
	velocity = velocity.normalized() * SPEED
	move_and_slide()
	_is_moving = true # 移動中.

## アニメーションの更新.
func _update_anim(delta:float) -> void:
	_anim_timer += delta
	var t = int(_anim_timer*2)%8
	if _is_moving:
		t = int(_anim_timer*6)%8
	_spr.frame = _get_anim_id(t)
	if _is_moving:
		_spr.frame += 2 # 移動中は +2

## 対応するアニメーションフレーム番号を取得.
func _get_anim_id(idx:int) -> int:
	var tbl = [32, 33, 34,35, 36, 37, 38, 39]

	'''
	match _dir:
		Vector2.LEFT:
			tbl = [0, 1]
		Vector2.UP:
			tbl = [4, 5]
		Vector2.RIGHT:
			tbl = [8, 9]
		_: #Vector2.DOWN:
			tbl = [12, 13]
	'''
			
	match _dir:
		Vector2.LEFT:
			tbl = [32, 33, 34,35, 36, 37, 38, 39]
		Vector2.RIGHT:
			tbl = [32, 33, 34,35, 36, 37, 38, 39]
			
	return tbl[idx]
