#if !defined(using_map_DATUM)

	#include "../../code/modules/lobby_music/chasing_time.dm"
	#include "../../code/modules/lobby_music/human.dm"
	#include "../../code/modules/lobby_music/marhaba.dm"
	#include "../../code/modules/lobby_music/treacherous_voyage.dm"
	#include "../../code/modules/lobby_music/comet_haley.dm"
	#include "../../code/modules/lobby_music/lysendraa.dm"

	#include "DeepSpace13.dmm"

	#include "DeepSpace13_areas.dm"
	#include "DeepSpace13_elevator.dm"
	#include "DeepSpace13_presets.dm"
	#define using_map_DATUM /datum/map/DeepSpace13

#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Deep Space 13

#endif