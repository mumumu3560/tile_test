extends Node
# ===========================
# 共通スクリプト.
# ===========================
# ※Commonで自動読み込みする.

# ---------------------------------------
# consts.
# ---------------------------------------
const GRID_SIZE = 64.0 # タイル1マスあたりのサイズ.
const TILE_SOURCE_ID = 0 # タイルセットの元データID.

## タイルレイヤー.
enum eTileLayer {
	BACKGROUND = 0, # 背景レイヤー.
	OBJECT = 1, # オブジェクトレイヤー.
}

## タイルの種類.
enum eTileType {
	NONE = 0, # 何もない.
	
	WALL = 1, # 壁
	FLOOR = 2, # 床.
}

## タイルの種類に対応する Atlas Coords
const TILE_TYPE_TBL = {
	eTileType.WALL: Vector2i(0, 0), # 壁のアトラス座標.
	eTileType.FLOOR: Vector2i(1, 0), # 床のアトラス座標.
}

# ---------------------------------------
# vars.
# ---------------------------------------
## タイルマップ.
var _tile:TileMap

# ---------------------------------------
# public functions.
# ---------------------------------------
## セットアップ
func setup(tile:TileMap) -> void:
	_tile = tile

## セル情報を取得する.
func get_cell_type(pos:Vector2) -> eTileType:
	var map_pos = _tile.local_to_map(pos)
	var data = _tile.get_cell_tile_data(eTileLayer.OBJECT, map_pos)
	if data == null:
		return eTileType.NONE
	return data.get_custom_data("type")

## 指定の位置にあるタイル消す.
func erase_cell(pos:Vector2, tile_layer:eTileLayer) -> void:
	var map_pos = _tile.local_to_map(pos) # ローカル座標をマップ座標に変換する
	_tile.erase_cell(tile_layer, map_pos)

## 指定位置にタイルを設定する.
func set_cell(pos:Vector2, tile_layer:eTileLayer, type:eTileType) -> void:
	if not type in TILE_TYPE_TBL:
		push_error("指定のtypeは存在しません type:%d"%type)
		return
		
	var map_pos = _tile.local_to_map(pos)
	var atlas_coords = TILE_TYPE_TBL[type]
	_tile.set_cell(tile_layer, map_pos, TILE_SOURCE_ID, atlas_coords)

# ---------------------------------------
# private functions.
# ---------------------------------------

