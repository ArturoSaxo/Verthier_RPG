extends Area2D

# On utilise @export pour pouvoir changer ces variables directement dans l'inspecteur
@export_file("*.tscn") var scene_destination: String = "res://scenes/maison_arthur_etage.tscn"
@export var id_du_point_de_spawn: String = "Spawn_Depuis_RDC"

func _ready():
	# On connecte le signal de détection de corps à notre fonction
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# On vérifie que c'est bien le joueur qui a marché sur le tapis
	if body.name == "joueur" or body is CharacterBody2D:
		# On dit au script global où le joueur doit apparaître dans la prochaine scène
		Global.target_spawn_id = id_du_point_de_spawn
		# On change de scène
		get_tree().change_scene_to_file(scene_destination)
