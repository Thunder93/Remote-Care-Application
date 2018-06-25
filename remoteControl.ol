include "console.iol"
include "interface.iol"

outputPort AccessControl {
	Location: "socket://localhost:8123/"
	Protocol: sodep
	Interfaces: AccessInterface
}

outputPort SmartHome {
	Location: "socket://localhost:8125/"
	Protocol: sodep
	Interfaces: SmartHomeClientInterface
}

main
{
	checkWriteAccess@AccessControl({.user=args[0],.smartHome=args[1],.deviceItem=args[2]} )(response);
	if(response){
		sendCommand@SmartHome({.smartHome=args[1],.deviceItem=args[2],.value=args[3]})(response);
		if(response){
			println@Console("Successful")()
			}else{
				println@Console("Failed")()
			}
			}else{
				println@Console("User is not allowed to access or device does not exist")()
			}
		}
