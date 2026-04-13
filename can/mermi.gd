extends Area2D

var speed = 400

# Mermi sahneye eklendiği (ateşlendiği) ilk an burası çalışır
func _ready():
	print("Piyuv! Mermi ateşlendi!")

func _process(delta):
	position.y -= speed * delta # Sürekli yukarı doğru gitsin
