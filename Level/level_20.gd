extends VideoStreamPlayer

func _on_finished():
	print("🎬 Video bitti, oyun kapanıyor...")
	get_tree().quit() # Oyunu tamamen kapatır. 
	# (Eğer ana menüye dönmek istersen get_tree().change_scene_to_file("res://AnaMenu.tscn") yazabilirsin)
