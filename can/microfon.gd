extends Area2D

var hp = 100

func _ready():
	# Timer'ı bağlama işlemini buradan da yapabilirsin veya editörden yapabilirsin
	pass

func take_damage(amount):
	hp -= amountprint("Boss Canı: ", hp)
	
	# Can sıfıra düşerse sahneyi bitir
	if hp <= 0:
		die()

func die():
	print("Boss Öldü! Şarkı sahnesine geçiliyor...")
	# Sonraki sahneye (şarkı sahnesine) geçiş yapıyoruz
	# "res://SarkiSahnesi.tscn" kısmını kendi sahnenin adıyla değiştir
	get_tree().change_scene_to_file("res://SarkiSahnesi.tscn")
