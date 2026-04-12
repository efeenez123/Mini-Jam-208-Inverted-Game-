extends Area2D

var harf_degeri = "" 
var hiz = 300.0
var ekstra_hiz = 1.0 

func _ready():
	if harf_degeri != "":
		$w.play(harf_degeri)

func _process(delta):
	position.x -= (hiz * ekstra_hiz) * delta
