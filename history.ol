include "console.iol"
include "interface.iol"
include "string_utils.iol"

inputPort HistoryLogging {
	Location: "socket://localhost:8124/"
	Protocol: sodep
	Interfaces: HistoryInterface
}

execution { concurrent }

define initSmartHome {
	
	global.smartHomes[index] = "Home" + index;
	with(global.smartHomes[index]) {
		.deviceItems[0] = "TV";	
		.deviceItems[0].itemStates[0].value = "On";	
		.deviceItems[0].itemStates[0].timestamp = "0";
		.deviceItems[1] = "Radio";	
		.deviceItems[1].itemStates[0].value = "On";	
		.deviceItems[1].itemStates[0].timestamp = "0"
	}
}

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	);
	
	index = 0;
	initSmartHome;
	index = 1;
	initSmartHome
}

main {	
	logCommand(command);
	{
		println@Console("Logging Command:" + command.smartHome+ " "+ command.deviceItem +" "+ command.value)()
		|
		foreach(shome : global.smartHomes) {
			request = shome;
			request.substring = command.smartHome;
			Contains@StringUtils(request)(response);
			//if(response)
			//{
			//	foreach(device : sHome.deviceItems) {
			//		request = device;
			//		request.substring = command.deviceItem;
			//		contains@StringUtils(request)(response);
			//		if(response)
			//		{
			//			last = device.itemStates[#device.Itemstates - 1];
			//			device.itemStates[#device.Itemstates] = {.value = command.value, .timestamp = --last.timestamp}
			//		}
			//	}
			}	
		}
	}
}