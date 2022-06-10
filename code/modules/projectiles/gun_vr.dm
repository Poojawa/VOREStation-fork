//Gun classifications for locker sanity
#define GUN_SIDEARM	0	//one handed sidearms, pistols and the sort.
#define GUN_LONGARM	1	//shotguns, rifles, etc.
#define GUN_HEAVY	2	//Stuff too large to sprite in the lockers.

//Extra vars for Gun lockers

/obj/item/weapon/gun/
	var/locker_class
	var/overlay_type

/* Side arms */

/obj/item/weapon/gun/projectile/colt
	locker_class = GUN_SIDEARM
	overlay_type = "revolver"

/obj/item/weapon/gun/projectile/sec
	locker_class = GUN_SIDEARM
	overlay_type = "pistol"

/obj/item/weapon/gun/projectile/silenced
	locker_class = GUN_SIDEARM
	overlay_type = "pistol"
/obj/item/weapon/gun/projectile/deagle
/obj/item/weapon/gun/projectile/gyropistol
/obj/item/weapon/gun/projectile/pistol
	locker_class = GUN_SIDEARM
	overlay_type = "pistol"
/obj/item/weapon/gun/projectile/aps
/obj/item/weapon/gun/projectile/revolver
	locker_class = GUN_SIDEARM
	overlay_type = "revolver"
/obj/item/weapon/gun/energy/taser
	locker_class = GUN_SIDEARM
	overlay_type = "taser"
/obj/item/weapon/gun/energy/stunrevolver
	locker_class = GUN_SIDEARM
	overlay_type = "revolver"
/obj/item/weapon/gun/energy/ionrifle/pistol
/obj/item/weapon/gun/energy/floragun
/obj/item/weapon/gun/energy/retro
/obj/item/weapon/gun/energy/alien
/obj/item/weapon/gun/energy/captain
/obj/item/weapon/gun/energy/gun
	locker_class = GUN_SIDEARM
	overlay_type = "energysmall"
/obj/item/weapon/gun/energy/particle
/obj/item/weapon/gun/projectile/lamia
	locker_class = GUN_SIDEARM
	overlay_type = "revolver"
/obj/item/weapon/gun/projectile/ecureuil
/obj/item/weapon/gun/energy/imperial
/obj/item/weapon/gun/projectile/automatic/mini_uzi
/obj/item/weapon/gun/projectile/contender
/obj/item/weapon/gun/energy/sickshot
/obj/item/weapon/gun/projectile/cell_loaded/combat

/* Long arms */
/obj/item/weapon/gun/energy/gun/rifle
	locker_class = GUN_LONGARM
	overlay_type = "energy"
/obj/item/weapon/gun/energy/gun/burst
/obj/item/weapon/gun/energy/gun/etommy
/obj/item/weapon/gun/energy/gun/nuclear
/obj/item/weapon/gun/energy/laser
	locker_class = GUN_LONGARM
	overlay_type = "laser"

/obj/item/weapon/gun/energy/ionrifle
	locker_class = GUN_LONGARM
	overlay_type = "ionrifle"
/obj/item/weapon/gun/energy/lasercannon
	locker_class = GUN_LONGARM
	overlay_type = "lasercannon"
/obj/item/weapon/gun/energy/xray
	locker_class = GUN_LONGARM
	overlay_type = "xray"
/obj/item/weapon/gun/energy/particle/advanced
/obj/item/weapon/gun/energy/monorifle
/obj/item/weapon/gun/energy/lasershotgun
/obj/item/weapon/gun/projectile/automatic/advanced_smg
/obj/item/weapon/gun/projectile/automatic/c20r
	locker_class = GUN_LONGARM
	overlay_type = "c20r"
/obj/item/weapon/gun/projectile/automatic/sts35
/obj/item/weapon/gun/projectile/automatic/pdw
/obj/item/weapon/gun/projectile/automatic/wt550
/obj/item/weapon/gun/projectile/automatic/z8
/obj/item/weapon/gun/projectile/automatic/as24
/obj/item/weapon/gun/projectile/automatic/p90
/obj/item/weapon/gun/projectile/automatic/tommygun
/obj/item/weapon/gun/projectile/automatic/bullpup
/obj/item/weapon/gun/projectile/automatic/combatsmg
/obj/item/weapon/gun/projectile/shotgun/pump
/obj/item/weapon/gun/energy/medigun
/obj/item/weapon/gun/projectile/cell_loaded/medical
/obj/item/weapon/gun/energy/netgun
/obj/item/weapon/gun/energy/pulse_rifle
	locker_class = GUN_LONGARM
	overlay_type = "pulse"

/* Heavy Weapons */
/obj/item/weapon/gun/energy/particle/cannon
/obj/item/weapon/gun/energy/mininglaser
/obj/item/weapon/gun/energy/sniperrifle
/obj/item/weapon/gun/projectile/automatic/l6_saw
/obj/item/weapon/gun/projectile/smartgun
/obj/item/weapon/gun/projectile/heavysniper
/obj/item/weapon/gun/projectile/SVD
/obj/item/weapon/gun/magnetic