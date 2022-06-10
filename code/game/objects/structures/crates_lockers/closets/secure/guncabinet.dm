/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	icon = 'icons/obj/guncabinet.dmi'
	icon_state = "base"
	req_one_access = list(access_armory)
	closet_appearance = null

/obj/structure/closet/secure_closet/guncabinet/Initialize()
	. = ..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/toggle()
	..()
	update_icon()

//VOREStation Add - gun context controls
/obj/structure/closet/secure_closet/guncabinet/open() //Don't dump everything to the floor, why would this be a good idea?
	if(opened)
		return FALSE
	if(!can_open())
		return FALSE
	opened = TRUE
	playsound(src, open_sound, 15, 1, -3)
	update_icon()
	return TRUE

/obj/structure/closet/secure_closet/guncabinet/close() //Don't auto scoop
	if(!opened)
		return FALSE
	if(!can_close())
		return FALSE
	opened = FALSE
	playsound(src, close_sound, 15, 1, -3)
	update_icon()
	return TRUE
//VOREStation Add End

/obj/structure/closet/secure_closet/guncabinet/update_icon()
	cut_overlays()
	if(opened)
		add_overlay("door_openold") //VOREStationEDIT all of these should be considered 'old' sprites, but keep backwards compatability.
	else
		var/lazors = 0
		var/shottas = 0
		for (var/obj/item/weapon/gun/G in contents)
			if (istype(G, /obj/item/weapon/gun/energy))
				lazors++
			if (istype(G, /obj/item/weapon/gun/projectile))
				shottas++
		for (var/i = 0 to 2)
			if(lazors || shottas) // only make icons if we have one of the two types.
				var/image/gun = image(icon(src.icon))
				if (lazors > shottas)
					lazors--
					gun.icon_state = "laserold"
				else if (shottas)
					shottas--
					gun.icon_state = "projectileold"
				gun.pixel_x = i*4
				add_overlay(gun)

		add_overlay("doorold")

		if(sealed)
			add_overlay("sealedold")

		if(broken)
			add_overlay("brokenold")
		else if (locked)
			add_overlay("lockedold")
		else
			add_overlay("openold")

//VOREStation Add Start
/obj/structure/closet/secure_closet/guncabinet/excursion
	name = "expedition weaponry cabinet"
	req_one_access = list(access_explorer,access_armory)

/obj/structure/closet/secure_closet/guncabinet/excursion/New()
	..()
	for(var/i = 1 to 2)
		new /obj/item/weapon/gun/energy/locked/frontier(src)
	for(var/i = 1 to 2)
		new /obj/item/weapon/gun/energy/locked/frontier/holdout(src)

//Fancier guncases
#define RACKONE 1
#define RACKTWO 2
#define RACKTHREE 3
#define RACKFOUR 4

#define GUN_SIDEARM	0
#define GUN_LONGARM	1
#define GUN_HEAVY	2


/obj/structure/closet/secure_closet/guncabinet/fancy
	name = "arms locker"
	icon_state = "shotguncase"
	desc = "A strong cabinet used for securing firearms."
	var/case_type = GUN_LONGARM
	var/gun_category = /obj/item/weapon/gun
	var/welded = FALSE
	anchored = TRUE

	var/rackslot1 = null
	var/rackslot2 = null
	var/rackslot3 = null
	var/rackslot4 = null

/obj/structure/closet/secure_closet/guncabinet/fancy/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(issilicon(user) || isalien(user))
		return

	if(!Adjacent(user))
		return

	if(istype(W, /obj/item/weapon/gun) && opened)
		var/obj/item/weapon/gun/G = W
		if(G.locker_class == case_type)
			if(!gun_check(G,user)) //If this check fails, it'll put the gun back in the person's hands and return
				return
			else
				G.loc = src
				G.add_fingerprint(user)
				to_chat(user, "<span class='notice'>You place [G] in [src].</span>")
				update_icon()
				return
		else
			to_chat(user, "<span class='notice'>You can't seem to fit [G] in [src] properly.</span>")
		return

	if(istype(W, /obj/item/weapon/weldingtool) && !opened && locked)
		var/obj/item/weapon/weldingtool/WT = W
		if (WT.remove_fuel(0, user))
			playsound(src, WT.usesound, 50, 1)
			user.visible_message("<span class='danger'>[user] begins cutting through [src]'s lock.</span>", "You start cutting through the lock.", "<span class='notice'>You hear a welder in use.</span>")
			if(do_after(user, (4 SECONDS) * WT.toolspeed))
				welded = TRUE
				opened = TRUE

	if(istype(W, /obj/item/weapon/melee/energy/blade) && !opened && locked)
		if(emag_act(INFINITY, user, "<span class='danger'>\The [src] has been sliced open by [user] with \an [W]</span>!", "<span class='danger'>You hear metal being sliced and sparks flying.</span>"))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, loc)
			spark_system.start()
			playsound(src, 'sound/weapons/blade1.ogg', 50, 1)
			playsound(src, "sparks", 50, 1)

/obj/structure/closet/secure_closet/guncabinet/fancy/attack_hand(mob/user as mob)
	if(issilicon(user) || isalien(user) || !Adjacent(usr))
		return
	if(opened)
		user.set_machine(src)
		tgui_interact(user)
		return
	if(locked)
		togglelock(user)
	else
		toggle(user)

/obj/structure/closet/secure_closet/guncabinet/fancy/proc/gun_check(obj/item/weapon/gun/G as obj, mob/user as mob)
	user.drop_from_inventory(G)
	if(!rackslot1)
		rackslot1 = G
		return TRUE
	else if(!rackslot2)
		rackslot2 = G
		return TRUE
	else if(!rackslot3)
		rackslot3 = G
		return TRUE
	else if(!rackslot4)
		rackslot4 = G
		return TRUE
	else
		user.put_in_hands(G) //pick it back up because it didn't work
		to_chat(user, "<span class='warning'>[src] is full.</span>")
		return FALSE

/obj/structure/closet/secure_closet/guncabinet/fancy/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GunLocker", name)
		ui.open()

/obj/structure/closet/secure_closet/guncabinet/fancy/tgui_status(mob/user)
	if(broken)
		return STATUS_CLOSE
	return ..()

/obj/structure/closet/secure_closet/guncabinet/fancy/tgui_data()
	var/list/data = list()

	data["broken"] = broken
	data["locked"] = locked
	data["open"] = opened
	var/obj/item/weapon/gun/G
	if(rackslot1)
		var/list/gun1 = list()
		for(G in rackslot1)
			gun1.Add(list(list(
				"name" = G.name,
				"charge" = G?.get_ammo_count()
			)))
		data["rackslot1"] = gun1
	else
		data["rackslot1"] = "Empty"
	if(rackslot2)
		var/list/gun2 = list()
		for(G in rackslot2)
			gun2.Add(list(list(
				"name" = G.name,
				"charge" = G?.get_ammo_count()
			)))
		data["rackslot2"] = gun2
	else
		data["rackslot2"] = "Empty"
	if(rackslot3)
		var/list/gun3 = list()
		for(G in rackslot3)
			gun3.Add(list(list(
				"name" = G.name,
				"charge" = G?.get_ammo_count()
				)))
		data["rackslot3"] = gun3
	else
		data["rackslot3"] = "Empty"
	if(rackslot4)
		var/list/gun4 = list()
		for(G in rackslot4)
			gun4.Add(list(list(
				"name" = G.name,
				"charge" = G?.get_ammo_count()
				)))
		data["rackslot4"] = gun4
	else
		data["rackslot4"] = "Empty"
	return data

/obj/structure/closet/secure_closet/guncabinet/fancy/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE

	usr.set_machine(src)
	add_fingerprint(usr)
	switch(action)
		if("open")
			toggle_open(usr)
			. = TRUE
		if("lock")
			toggle_lock(usr)
			. = TRUE
		if("retrieve")
			if("rackslot1")
				retrieve_gun(rackslot1, usr)
			if("rackslot2")
				retrieve_gun(rackslot2, usr)
			if("rackslot3")
				retrieve_gun(rackslot3, usr)
			if("rackslot4")
				retrieve_gun(rackslot4, usr)
			. = TRUE

/obj/structure/closet/secure_closet/guncabinet/fancy/proc/retrieve_gun(obj/item/weapon/gun/G as obj, mob/user as mob)
	if(Adjacent(user))
		user.put_in_hands(G)
		to_chat(user, "<span class='warning'>[src] is full.</span>")

/obj/structure/closet/secure_closet/guncabinet/fancy/proc/slot_icons(obj/item/weapon/gun/G)
	var/position = 0
	for(G in contents)

	return position


/obj/structure/closet/secure_closet/guncabinet/fancy/proc/toggle_open(mob/user as mob)
	if(locked)
		to_chat(user, "<font color='red'>It's locked.</font>")
		return
	opened = !opened
	return

/obj/structure/closet/secure_closet/guncabinet/fancy/proc/toggle_lock(mob/user as mob)
	if(opened)
		return
	locked = !locked
	return

/obj/structure/closet/secure_closet/guncabinet/fancy/update_icon()
	cut_overlays()
	if(contents)
		for(var/i in 1 to contents.len)
			var/obj/item/weapon/gun/G = contents[i]
			var/mutable_appearance/gun_overlay = mutable_appearance(icon, G.overlay_type)
			gun_overlay.pixel_x = 0 //reset, just in case.
			if(rackslot1 && rackslot1 == G)
				gun_overlay.pixel_x = 3 * (RACKONE - 1)
				add_overlay(gun_overlay)
			else if(rackslot2 && rackslot2 == G)
				gun_overlay.pixel_x = 3 * (RACKTWO - 1)
				add_overlay(gun_overlay)
			else if(rackslot3 && rackslot3 == G)
				gun_overlay.pixel_x = 3 * (RACKTHREE - 1)
				add_overlay(gun_overlay)
			else if(rackslot4 && rackslot4 == G)
				gun_overlay.pixel_x = 3 * (RACKFOUR - 1)
				add_overlay(gun_overlay)
				//Probably a better way of doing this but my brain's smooth.

	if(welded)
		add_overlay("[icon_state]_cut")
		layer = OBJ_LAYER
		return
	else if(opened)
		add_overlay("[icon_state]_open")
		layer = OBJ_LAYER
		return
	else
		add_overlay("[icon_state]_door")
		if(broken)
			add_overlay("[icon_state]_off")
			add_overlay("[icon_state]_sparking")
		else if(locked)
			add_overlay("[icon_state]_locked")
		else
			add_overlay("[icon_state]_unlocked")
		return

/obj/structure/closet/secure_closet/guncabinet/fancy/shotgun
	name = "long arms locker"
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/guncabinet/fancy/rifle
	name = "long arms locker"
	icon_state = "riflecase"
	desc = "A strong cabinet used for securing firearms. This one is for long arms such as rifles and shotguns."


/obj/structure/closet/secure_closet/guncabinet/fancy/rifle/wood
	icon_state = "riflefancy"


/obj/structure/closet/secure_closet/guncabinet/fancy/pistol
	name = "small arms locker"
	icon_state = "pistolcase"
	desc = "A strong cabinet used for securing firearms. This one is for hand-held sidearms."
	case_type = GUN_SIDEARM

/obj/structure/closet/secure_closet/guncabinet/fancy/pistol/wood
	icon_state = "fancypistol"

#undef RACKONE
#undef RACKTWO
#undef RACKTHREE
#undef RACKFOUR

#undef GUN_SIDEARM
#undef GUN_LONGARM
#undef GUN_HEAVY
//VOREStation Add End