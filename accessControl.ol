include "console.iol"
include "interface.iol"

inputPort AccessControl {
Location: "socket://localhost:8123/"
Protocol: sodep
Interfaces: AccessInterface
}

main
{
			sendCommand(command)(response){
			println@Console("Recieved Message: "+ command.smartHome+ " "+command.deviceItem +" "+ command.value)();
			response=true
	}
}
