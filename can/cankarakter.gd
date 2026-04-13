extends CharacterBody2D

var speed = 450.0
var health = 100
var mermi_sahnesi = preload("res://can/mermi.tscn")

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var hasar_sesi = $HasarSesi

func _ready():
	add_to_group("Player")
	
	# OYUN BAŞLAR BAŞLAMAZ BUTONU GİZLE (GARANTİ YÖNTEM)
	var buton = get_tree().current_scene.get_node_or_null("UI/YenidenDeneButonu")
	if buton:
		buton.visible = false

func _physics_process(_delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A): direction.x -= 1
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D): direction.x += 1
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W): direction.y -= 1
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S): direction.y += 1

	velocity = direction.normalized() * speed
	move_and_slide()

	# EKRAN SINIRLARI
	global_position.x = clamp(global_position.x, -512, 512)
	global_position.y = clamp(global_position.y, 4, 250)

	# ANİMASYON VE YÖN
	if direction != Vector2.ZERO:
		anim.play("new_animation") 
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
	else:
		anim.stop()

	if Input.is_action_just_pressed("ui_accept"): 
		ates_et()

func ates_et():
	if mermi_sahnesi:
		var yeni_mermi = mermi_sahnesi.instantiate()
		get_tree().current_scene.add_child(yeni_mermi)
		yeni_mermi.global_position = global_position

# CAN BARI, SES VE ÖLÜM KONTROLÜ
func hasar_al(miktar):
	health -= miktar
	
	# İŞTE SESİ BURADA ÇALDIRIYORUZ!
	if hasar_sesi:
		hasar_sesi.play()
	
	# UI katmanındaki can barını bul ve değerini güncelle
	var bar = get_tree().current_scene.get_node_or_null("UI/PlayerCanBar")
	if bar:
		bar.value = health
	
	print("💔 Ah! Hasar aldık! Kalan Canımız: ", health)
	
	if health <= 0:
		print("☠️ BİZ ÖLDÜK! Game Over.")
		
		# Ölünce UI katmanındaki gizli butonu bul ve görünür yap
		var buton = get_tree().current_scene.get_node_or_null("UI/YenidenDeneButonu")
		if buton:
			buton.visible = true
			
		queue_free()
