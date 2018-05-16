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
