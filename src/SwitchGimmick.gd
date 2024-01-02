extends Area2D
# ===========================
# スイッチギミック.
# ===========================

# ---------------------------------------
# onready.
# ---------------------------------------
@onready var _spr = $Sprite

# ---------------------------------------
# export.
# ---------------------------------------
@export var unlock_target:CollisionObject2D # スイッチを踏んだ時に消すオブジェクト.

# ---------------------------------------
# signal functions.
# ---------------------------------------
func _on_body_entered(body: Node2D) -> void:
	# スイッチを踏んだ
	if is_instance_valid(unlock_target):
		# ターゲットを消す.
		unlock_target.queue_free()
		_spr.frame = 1 # 踏んだ状態にする.
