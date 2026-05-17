extends CharacterBody2D

# Vitesse de déplacement réglable directement depuis l'Inspecteur Godot
@export var speed: float = 100.0

# Référence au nœud d'animation
@onready var animated_sprite = $AnimatedSprite2D

# Variable pour retenir la dernière direction (par défaut : face à l'écran)
var last_direction: String = "down"

func _ready() -> void:
	# GESTION DU SPAWN (TRANSITION DE SCÈNE)
	if Global.target_spawn_id != "":
		# On cherche un nœud Marker2D qui porte ce nom dans la scène actuelle
		var spawn_point = get_node_to_spawn(Global.target_spawn_id)
		if spawn_point:
			global_position = spawn_point.global_position
		Global.target_spawn_id = "" # Réinitialisation de la variable globale

func _physics_process(_delta: float) -> void:
	# 1. Récupération du vecteur de direction (x: -1 à 1, y: -1 à 1)
	# get_vector gère nativement la normalisation (évite de courir plus vite en diagonale)
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Gestion du mouvement et des animations
	if direction != Vector2.ZERO:
		velocity = direction * speed
		update_walk_animation(direction)
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle_" + last_direction)

	# 3. Application du déplacement et gestion des collisions
	move_and_slide()

func update_walk_animation(direction: Vector2) -> void:
	# Détermination de la direction dominante (4 directions strictes type Pokémon)
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			last_direction = "right"
		else:
			last_direction = "left"
	else:
		if direction.y > 0:
			last_direction = "down"
		else:
			last_direction = "up"
			
	# Lecture de l'animation correspondante (ex: "walk_left")
	animated_sprite.play("walk_" + last_direction)

func get_node_to_spawn(id: String) -> Node:
	# Cherche récursivement un Marker2D avec le bon nom dans la scène
	return get_tree().current_scene.find_child(id, true, false)
