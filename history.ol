include "console.iol"
include "interface.iol"
include "database.iol"

inputPort HistoryLogging {
	Location: "socket://localhost:8124/"
	Protocol: sodep
	Interfaces: HistoryInterface
}

execution { concurrent }

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	);
	with ( connectionInfo ){
	    .host = "localhost";
	    .driver = "mysql";
	    .port = 3306;
	    .database = "world?useSSL=false";
	    .username = "root";
	    .password = "root"
	};
	connect@Database(connectionInfo )(void);
	checkConnection@Database( void )( void );
	println@Console("Connected  to  database .")();
	scope ( createTable ) {
  	install ( SQLException => println@Console("History table already there")());
	  updateRequest ="CREATE TABLE history(smartHome VARCHAR(50) NOT NULL,"+
									 "deviceItem VARCHAR(50) NOT NULL, value VARCHAR(50) NOT NULL,"+
									 "timestamp TIMESTAMP NOT NULL default CURRENT_TIMESTAMP," +
	            		 "PRIMARY KEY(smartHome,deviceItem,value,timestamp));";
	  update@Database( updateRequest )( ret );
		println@Console("Created HistoryTable")()
	  }
}

main {
	logCommand(command);
		println@Console("Logging Command:" + command.smartHome+ " "+ command.deviceItem +" "+ command.value)();
		updateRequest="INSERT INTO history(smartHome,deviceItem,value) VALUES('"+command.smartHome+
									"', '"+command.deviceItem+"', '"+command.value+"')";
		update@Database(updateRequest)(response)
}
