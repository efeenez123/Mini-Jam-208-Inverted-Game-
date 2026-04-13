extends CharacterBody2D

@export var tilemap : TileMapLayer

# --- YENİ EKLENEN SATIR ---
@onready var can_label = $CanvasLayer/CanYazisi 
# -------------------------
@onready var ses = $yurume
@onready var sesS = $sari
@onready var sesK = $kirmizi

var tablo = []
var tablobomba = []

var yatay = 16
var dikey = 16

var karakter_transform
var karakter_kordinant

var Can = 100
var hasar = false

var bomba_patlama_süresi = 1.5
var sifirlama_sure = 2.5
var hedef_bomba = 20
var yerlestirilen_bomba = 0

func _process(delta: float) -> void:
	if Can == 0:
		get_tree().reload_current_scene()

func _ready() -> void:
	# Oyun başlarken canımızı ekrana yazdırıyoruz
	can_label.text = "Can: " + str(Can)
	
	karakter_kordinant = tilemap.local_to_map(global_position)
	for x in range(yatay):
		tablo.append([])
		for y in range(dikey):
			tablo[x].append(0)
			tilemap.set_cell(Vector2i(x,y),0,Vector2i(0,0))
	Duzenek()

			
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		
		karakter_kordinant = tilemap.local_to_map(global_position)
		if karakter_kordinant.x >= 0 and karakter_kordinant.x < yatay  and karakter_kordinant.y >= 0 and karakter_kordinant.y < dikey  : 
			
			if event.is_action_pressed("a") and karakter_kordinant.x > 0: 
				karakter_kordinant = Vector2i(karakter_kordinant.x -1 , karakter_kordinant.y) 
				karakter_kordinant = karakter_kordinant 
				print(karakter_kordinant)
				ses.play()
				
			if event.is_action_pressed("d") and karakter_kordinant.x < yatay -1:
				karakter_kordinant = Vector2i(karakter_kordinant.x +1 , karakter_kordinant.y)
				print(karakter_kordinant)
				ses.play()
				
			if event.is_action_pressed("w") and karakter_kordinant.y > 0:
				karakter_kordinant = Vector2i(karakter_kordinant.x, karakter_kordinant.y -1)
				print(karakter_kordinant)
				ses.play()
				
			if event.is_action_pressed("s") and karakter_kordinant.y < dikey -1 :
				karakter_kordinant = Vector2i(karakter_kordinant.x, karakter_kordinant.y +1 )
				print(karakter_kordinant)
				ses.play()
				
			global_position = tilemap.map_to_local(karakter_kordinant)
			HasarKontrol()
			
func sifirlama():
	await get_tree().create_timer(sifirlama_sure).timeout
	for x in range(yatay):
		for y in range(dikey):
			tablo[x][y] = 0
			tilemap.set_cell(Vector2i(x,y),0,Vector2i(0,0))
	yerlestirilen_bomba = 0
	
func RastGele_Bomba():
	while yerlestirilen_bomba < hedef_bomba:
		var rastgeleY =  int(randi() % yatay)
		var rastgeleX = int(randi() % dikey)
		if tablo[rastgeleX][rastgeleY] == 0:
			tablo[rastgeleX][rastgeleY] = 1
			tilemap.set_cell(Vector2i(rastgeleX,rastgeleY),0,Vector2i(1,0))
			sesS.play()
			yerlestirilen_bomba = yerlestirilen_bomba + 1 
	RastGele_Bomba_Aktif()
	sifirlama()
		
func RastGele_Bomba_Aktif():
	await get_tree().create_timer(bomba_patlama_süresi).timeout
	for a in range(yatay):
		for b in range(dikey):
			if tablo[a][b] == 1:
				tilemap.set_cell(Vector2i(a,b),0,Vector2i(2,0))
				sesK.play()
				tablo[a][b] = 2 
	HasarKontrol()
		
func HasarKontrol():
	if tablo[karakter_kordinant.x][karakter_kordinant.y] == 2 :
		Can = Can - 10
		print(Can)
		# --- YENİ EKLENEN SATIR ---
		# Hasar yediğimizde ekrandaki yazıyı anında güncelliyoruz
		can_label.text = "Can: " + str(Can)
		# -------------------------
		
func Duzenek():
	hedef_bomba = hedef_bomba + 10
	RastGele_Bomba()
	await get_tree().create_timer(5).timeout
	hedef_bomba = hedef_bomba + 11
	RastGele_Bomba()
	await get_tree().create_timer(4).timeout
	hedef_bomba = hedef_bomba + 12
	RastGele_Bomba()
	await get_tree().create_timer(3).timeout
	hedef_bomba = hedef_bomba + 13
	RastGele_Bomba()
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 14
	RastGele_Bomba()
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 15
	RastGele_Bomba()
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 17
	RastGele_Bomba()
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 20
	RastGele_Bomba()
	sifirlama_sure = 2 
	bomba_patlama_süresi = 1 
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 20
	RastGele_Bomba()
	print("Son20")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 20 
	RastGele_Bomba()
	print("Son")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 32 
	RastGele_Bomba()
	print("Son30")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 20 
	RastGele_Bomba()
	print("Son40")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 20
	RastGele_Bomba()
	print("Son")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 3
	RastGele_Bomba()
	print("Son3")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 3
	RastGele_Bomba()
	print("Son33")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 1
	RastGele_Bomba()
	print("Son333")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 1
	RastGele_Bomba()
	print("Son333")
	await get_tree().create_timer(2.5).timeout
	hedef_bomba = hedef_bomba + 1
	RastGele_Bomba()
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://Level/level_5.tscn")
