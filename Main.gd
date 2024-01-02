extends Node2D


# ※ここを追加
@onready var _tile = $TileMap # タイルマップ


func _ready() -> void:
	# macOSだとサイズがなぜが半分になるので拡大する.
	#DisplayServer.window_set_size(Vector2i(1152*2, 648*2))
	
	# ※ここを追加
	# タイルマップを自動読み込みモジュールに設定する
	Common.setup(_tile)
	
func _process(delta: float) -> void:
	pass
