#include "script_component.hpp"

class Weather
{
	title = $STR_A3_rscattributeovercast_title;
	values[] = {0, 0.25, 0.5, 0.75, 1};
	texts[] = {
		$STR_A3_rscattributeovercast_value000_tooltip,
		$STR_A3_rscattributeovercast_value025_tooltip,
		$STR_A3_rscattributeovercast_value050_tooltip,
		$STR_A3_rscattributeovercast_value075_tooltip,
		$STR_A3_rscattributeovercast_value100_tooltip
	};
	default = TLD_DEFAULT_OVERCAST;
};
