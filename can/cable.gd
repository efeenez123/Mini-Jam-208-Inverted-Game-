extends Area2D

var health = 30 # 3 mermide ölür (10x3)
var speed = 150

func _process(delta):
	position.y += speed * delta # Sürekli aşağı insin

func _on_area_entered(area):
	if area.is_in_group("Bullet"): 
		health -= 10
		print("💥 Kablo vuruldu! Kablonun Kalan Canı: ", health)
		area.queue_free() # Mermiyi yok et
		
		if health <= 0:
			print("🔥 Kablo koptu/yok oldu! Boss'a 5 hasar gönderiliyor...")
			get_tree().call_group("Boss", "take_damage", 5)
			queue_free() 
			
	elif area.is_in_group("Player"): 
		print("⚠️ EYVAH! Kablo bize çarptı!")
		area.hasar_al(25) # Bize 25 hasar ver
		queue_free() # Kendini yok et
