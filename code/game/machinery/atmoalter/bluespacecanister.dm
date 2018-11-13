/obj/machinery/portable_atmospherics/canister/bluespace
	name = "\improper Bluespace Canister: \[CAUTION\]"
	icon = 'icons/obj/bluespace.dmi'
	req_access = list(core_access_engineering_programs)
	volume = 200000
	health = 600

/obj/machinery/portable_atmospherics/canister/bluespace/after_load()
	..()
	update_icon()

/obj/machinery/portable_atmospherics/canister/bluespace/drain_power()
	. = ..()
/obj/machinery/portable_atmospherics/canister/bluespace/update_icon()
	. = ..()
/obj/machinery/portable_atmospherics/canister/bluespace/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	. = ..()
/obj/machinery/portable_atmospherics/canister/bluespace/Process()
	. = ..()

/obj/machinery/portable_atmospherics/canister/bluespace/OnTopic(var/mob/user, href_list, state)
	if(href_list["toggle"])
		if(allowed(user))
			if (valve_open)
				if (holding)
					release_log += "Valve was <b>closed</b> by [user] ([user.ckey]), stopping the transfer into the [holding]<br>"
				else
					release_log += "Valve was <b>closed</b> by [user] ([user.ckey]), stopping the transfer into the <font color='red'><b>air</b></font><br>"
			else
				if (holding)
					release_log += "Valve was <b>opened</b> by [user] ([user.ckey]), starting the transfer into the [holding]<br>"
				else
					release_log += "Valve was <b>opened</b> by [user] ([user.ckey]), starting the transfer into the <font color='red'><b>air</b></font><br>"
					log_open()
			valve_open = !valve_open
			. = TOPIC_REFRESH
		else
			to_chat(user,"<span class='warning'>Access denied.</span>")

	else if (href_list["remove_tank"])
		if(!holding)
			return TOPIC_HANDLED
		if (valve_open)
			valve_open = 0
			release_log += "Valve was <b>closed</b> by [user] ([user.ckey]), stopping the transfer into the [holding]<br>"
		if(istype(holding, /obj/item/weapon/tank))
			holding.manipulated_by = user.real_name
		holding.dropInto(loc)
		holding = null
		update_icon()
		. = TOPIC_REFRESH

	else if (href_list["pressure_adj"])
		if (allowed(user))
			var/diff = text2num(href_list["pressure_adj"])
			if(diff > 0)
				release_pressure = min(10*ONE_ATMOSPHERE, release_pressure+diff)
			else
				release_pressure = max(ONE_ATMOSPHERE/10, release_pressure+diff)
			. = TOPIC_REFRESH
		else
			to_chat(user,"<span class='warning'>Access denied.</span>")

	else if (href_list["relabel"])
		if (!can_label)
			return 0
		var/list/colors = list(\
			"\[N2O\]" = "redws", \
			"\[N2\]" = "red", \
			"\[O2\]" = "blue", \
			"\[Hydrogen\]" = "purple", \
			"\[Phoron\]" = "orange", \
			"\[CO2\]" = "black", \
			"\[Air\]" = "grey", \
			"\[CAUTION\]" = "yellow", \
			"\[Reagents\]" = "cyanws", \
		)
		var/label = input(user, "Choose canister label", "Gas canister") as null|anything in colors
		if (label && CanUseTopic(user, state))
			canister_color = colors[label]
			icon_state = colors[label]
			name = "\improper Canister: [label]"
		update_icon()
		. = TOPIC_REFRESH


/obj/machinery/portable_atmospherics/canister/bluespace/sleeping_agent
	name = "\improper Bluespace Canister: \[N2O\]"
	icon_state = "redws"
	canister_color = "redws"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/nitrogen
	name = "\improper Bluespace Canister: \[N2\]"
	icon_state = "red"
	canister_color = "red"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/nitrogen/prechilled
	name = "\improper Bluespace Canister: \[N2 (Cooling)\]"


/obj/machinery/portable_atmospherics/canister/bluespace/oxygen
	name = "\improper Bluespace Canister: \[O2\]"
	icon_state = "blue"
	canister_color = "blue"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/oxygen/prechilled
	name = "\improper Bluespace Canister: \[O2 (Cryo)\]"
	start_pressure = 20 * ONE_ATMOSPHERE


/obj/machinery/portable_atmospherics/canister/bluespace/hydrogen
	name = "\improper Bluespace Canister: \[Hydrogen\]"
	icon_state = "purple"
	canister_color = "purple"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/phoron
	name = "\improper Bluespace Canister \[Phoron\]"
	icon_state = "orange"
	canister_color = "orange"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/carbon_dioxide
	name = "\improper Bluespace Canister \[CO2\]"
	icon_state = "black"
	canister_color = "black"
	can_label = 0


/obj/machinery/portable_atmospherics/canister/bluespace/air
	name = "\improper Bluespace Canister \[Air\]"
	icon_state = "grey"
	canister_color = "grey"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/bluespace/sleeping_agent/init_air_content()
	..()
	src.air_contents.adjust_gas("sleeping_agent", MolesForPressure())
	src.update_icon()
/obj/machinery/portable_atmospherics/canister/bluespace/nitrogen/init_air_content()
	..()
	src.air_contents.adjust_gas("nitrogen", MolesForPressure())
	src.update_icon()

/obj/machinery/portable_atmospherics/canister/bluespace/hydrogen/init_air_content()
	..()
	src.air_contents.adjust_gas("hydrogen", MolesForPressure())
	src.update_icon()
/obj/machinery/portable_atmospherics/canister/bluespace/phoron/init_air_content()
	..()
	src.air_contents.adjust_gas("phoron", MolesForPressure())
	src.update_icon()
/obj/machinery/portable_atmospherics/canister/bluespace/carbon_dioxide/init_air_content()
	..()
	src.air_contents.adjust_gas("carbon_dioxide", MolesForPressure())
	src.update_icon()
/obj/machinery/portable_atmospherics/canister/bluespace/air/init_air_content()
	..()
	src.air_contents.adjust_gas("air", MolesForPressure())
	src.update_icon()



/obj/machinery/portable_atmospherics/canister/bluespace/empty
	start_pressure = 0
	can_label = 1
	var/obj/machinery/portable_atmospherics/canister/bluespace/canister_type = /obj/machinery/portable_atmospherics/canister/bluespace

/obj/machinery/portable_atmospherics/canister/bluespace/empty/air
	icon_state = "grey"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/air
/obj/machinery/portable_atmospherics/canister/bluespace/empty/oxygen
	icon_state = "blue"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/oxygen
/obj/machinery/portable_atmospherics/canister/bluespace/empty/phoron
	icon_state = "orange"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/phoron
/obj/machinery/portable_atmospherics/canister/bluespace/empty/nitrogen
	icon_state = "red"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/nitrogen
/obj/machinery/portable_atmospherics/canister/bluespace/empty/carbon_dioxide
	icon_state = "black"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/carbon_dioxide
/obj/machinery/portable_atmospherics/canister/bluespace/empty/sleeping_agent
	icon_state = "redws"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/sleeping_agent
/obj/machinery/portable_atmospherics/canister/bluespace/empty/hydrogen
	icon_state = "purple"
	canister_type = /obj/machinery/portable_atmospherics/canister/bluespace/hydrogen