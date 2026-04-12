extends Area2D

var health = 40 # 3 mermide ölür (10x3)
var speed = 250

func _process(delta):
	position.y += speed * delta # Sürekli aşağı insin

# Bir şeye çarptığında burası çalışır
func _on_area_entered(area):
	if area.is_in_group("Bullet"): # Çarpan şey mermimizse
		health -= 10
		area.queue_free() # Mermiyi yok et
		
		if health <= 0:
			# Boss'a 5 hasar yolla ve kendini yok et
			get_tree().call_group("Boss", "take_damage", 5)
			queue_free() 
			
	elif area.is_in_group("Player"): # Çarpan şey biz isek
		area.hasar_al(20) # Bize 25 hasar ver
		queue_free() # Kendini yok et


# Kabloya katı bir gövde (Bizim karakter) çarptığında burası çalışır
func _on_body_entered(body):
	if body.is_in_group("Player"): 
		print("⚠️ EYVAH! Kablo katı bedenimize çarptı!")
		body.hasar_al(20) # Bize 25 hasar ver
		queue_free() # Kablo kendini yok etsina
	pass # Replace with function body.
