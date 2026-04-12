extends Area2D

var icerideki_notalar = []
var puan = 0
var isabet_sayisi = 0
var kacan_sayisi = 0

@onready var skor_label = get_node("../CanvasLayer/SkorYazisi")

func _on_area_entered(area: Area2D) -> void:
	if "harf_degeri" in area:
		icerideki_notalar.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area in icerideki_notalar:
		icerideki_notalar.erase(area)
		kacan_sayisi += 1
		area.queue_free() 
		oyun_bitti_mi_kontrol_et()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if icerideki_notalar.size() > 0:
			var hedef_nota = icerideki_notalar[0]
			var basilan_harf = ""
			
			if Input.is_action_just_pressed("w"): basilan_harf = "w"
			elif Input.is_action_just_pressed("a"): basilan_harf = "a"
			elif Input.is_action_just_pressed("s"): basilan_harf = "s"
			elif Input.is_action_just_pressed("d"): basilan_harf = "d"
			
			if basilan_harf != "":
				if basilan_harf == hedef_nota.harf_degeri:
					isabet_sayisi += 1
					puan += 10
					
					# Arayüzü güncelle (0/30 hedefi görünüyor)
					skor_label.text = str(isabet_sayisi) + "/30"
					
					icerideki_notalar.pop_front()
					hedef_nota.queue_free()
					oyun_bitti_mi_kontrol_et()
				else:
					print("Yanlış tuş!")

func oyun_bitti_mi_kontrol_et():
	# Toplam 70 nota geçtiğinde oyun sonu kararı verilir
	if (isabet_sayisi + kacan_sayisi) >= 70:
		if isabet_sayisi >= 30:
			skor_label.text = "BAŞARILI! (" + str(isabet_sayisi) + "/70)"
		else:
			skor_label.text = "BAŞARISIZ! (" + str(isabet_sayisi) + "/70)"
