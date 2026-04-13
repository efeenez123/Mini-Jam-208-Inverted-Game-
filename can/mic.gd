extends Area2D

var hp = 60

# İSİMLERİ GÜNCELLENMİŞ NOTA HAVUZU
var nota_havuzu = [
	preload("res://can/1c.tscn"),
	preload("res://can/2c.tscn"),
	preload("res://can/3c.tscn"),
	preload("res://can/4c.tscn"),
	preload("res://can/5c.tscn"),
	preload("res://can/6c.tscn"),
	preload("res://can/7c.tscn"),
	preload("res://can/8c.tscn")
]
# Aktif olarak içinden çekeceğimiz liste
var firlatilacak_notalar = []

@onready var timer = $Timer
@onready var anim = $AnimationPlayer

func _ready():
	add_to_group("Boss")
	anim.play("mic")
	
	# Başlangıçta listeyi doldur
	liste_yenile()
	
	timer.wait_time = 1.2
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

# Liste boşalınca veya ilk başta notaları karıştırıp dolduran fonksiyon
func liste_yenile():
	firlatilacak_notalar = nota_havuzu.duplicate() # Orijinal listeyi kopyala
	firlatilacak_notalar.shuffle() # Listeyi rastgele karıştır
	print("🎼 Nota listesi tazelendi ve karıştırıldı!")

func _on_timer_timeout():
	# Eğer listede nota kalmadıysa listeyi tekrar doldur
	if firlatilacak_notalar.size() == 0:
		liste_yenile()
	
	# Listenin en sonundaki notayı seç ve listeden çıkart (Pop mantığı)
	var secilen_nota_sahnesi = firlatilacak_notalar.pop_back()
	
	if secilen_nota_sahnesi:
		var yeni_nota = secilen_nota_sahnesi.instantiate()
		
		# Artık klasör aramıyor, direkt ana sahneye ekliyor!
		get_tree().current_scene.add_child(yeni_nota)
		
		var rastgele_x = global_position.x + randf_range(-500, 500)
		yeni_nota.global_position = Vector2(rastgele_x, -300)
func take_damage(amount):
	hp -= amount
	
	var bar = get_tree().current_scene.get_node_or_null("UI/BossCanBar")
	if bar:
		bar.value = hp
	
	if hp <= 0:
		# BOSS ÖLDÜ! DİĞER SAHNEYE GEÇ:
		# DİKKAT: "res://IkinciSahne.tscn" yazan yere kendi 2. sahnenin tam adını yazmalısın!
		get_tree().change_scene_to_file("res://IkinciSahne.tscn") 
		queue_free()
