extends Node2D

var spam_sahnesi = preload("res://spam.tscn")
var harfler = ["w", "a", "s", "d"]

var uretilen_nota = 0
var hiz_carpani = 1.0

func _on_timer_timeout():
	# 70 NOTA SINIRI
	if uretilen_nota >= 70:
		$Timer.stop()
		return
		
	uretilen_nota += 1
	
	var yeni_spam = spam_sahnesi.instantiate()
	yeni_spam.harf_degeri = harfler.pick_random()
	yeni_spam.ekstra_hiz = hiz_carpani 
	yeni_spam.global_position = $Marker2D.global_position 
	get_tree().current_scene.add_child(yeni_spam)
	
	# AGRESİF ZORLUK ARTIŞI
	# Bekleme süresi min 0.22 saniyeye kadar düşebilir (Çok seri!)
	$Timer.wait_time = max($Timer.wait_time - 0.05, 0.22)
	
	# Maksimum ilerleme hızı 4.5 katına çıkabilir
	hiz_carpani = min(hiz_carpani + 0.12, 4.5)
