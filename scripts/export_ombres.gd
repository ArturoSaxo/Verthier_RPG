extends Node2D

func _ready():
	# 1. On récupère les références proprement
	var container = $SubViewportContainer
	var viewport = $SubViewportContainer/SubViewport
	
	# 2. On s'assure que le Viewport est actif
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	# 3. ON ATTEND LE SIGNAL DU GPU (Le secret est là)
	# On attend que le moteur ait fini de dessiner la frame actuelle
	await RenderingServer.frame_post_draw
	
	# 4. On attend une frame de plus pour la sécurité
	await get_tree().process_frame

	# 5. Capture de la texture
	var img = viewport.get_texture().get_image()
	
	if img == null or img.is_empty():
		print("ERREUR : L'image est encore vide ou nulle.")
		return

	# 6. Sauvegarde
	var path = "res://assets/atlas_ombres.png"
	var error = img.save_png(path)
	
	if error == OK:
		print("SUCCÈS : Atlas sauvegardé ! (Vérifiez le dossier assets)")
	else:
		print("ÉCHEC : Erreur de sauvegarde ", error)
