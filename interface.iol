type Command:void {
	.smartHome:string
	.deviceItem:string
	.value:string
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

type SmartHome:string {
	.deviceItems*:string {
		.itemStates*:ItemState	
	}
}

interface AccessInterface {
	RequestResponse:
		checkWriteAccess(AccessRequest)(bool),
		checkReadAccess(AccessRequest)(bool)
}

interface HistoryInterface {
	OneWay:
		logCommand( Command )
}

interface SmartHomeClientInterface {
	RequestResponse:
		sendCommand(Command)(bool)
}
