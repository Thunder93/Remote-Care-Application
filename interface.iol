type Command:void {
	.smartHome:string
	.deviceItem:string
	.value:string
	//.commandType:string //Sinn?
}

type AccessRequest:void {
	.user:string
	.smartHome:string
	.deviceItem:string
}

type ItemState:void {
	.value:string
	.timestamp:string
}

type SmartHome:void {
	.name:string
	.deviceItems*:void {
		.name:string
		.itemStates*:ItemState	
	}
}

interface AccessInterface {
	RequestResponse:
		checkWriteAccess(AccessRequest)(bool)
}

interface HistoryInterface {
	OneWay:
		logCommand( Command )
}

interface SmartHomeClientInterface {
	RequestResponse:
		sendCommand(Command)(bool)
}
