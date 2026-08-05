///Pick-and-choose undersuits for people to customize with. Includes Teshari! able to be fitted to anyone else too.
/obj/item/clothing/modular
	name = DEVELOPER_WARNING_NAME // "Clothing"
	icon = 'icons/inventory/uniform/modular_clothes.dmi'
	sprite_sheets = list(
		SPECIES_TESHARI = 'icons/inventory/uniform/modular_teshari.dmi')
	/// What sort of pants are available? Tie? etc
	var/list/possible_options
	///Which did we choose
	var/list/decorations
	///to limit decorations per rank, assistant can't have gold rank boards etc
	var/required_access
