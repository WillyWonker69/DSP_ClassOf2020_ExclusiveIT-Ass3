// import ballerina/io;
import ballerina/graphql;
import ballerinax/kafka;


kafka:ProducerConfiguration ProdConfigs = {
    bootstrapServers: "localhost:9092",
    clientId: "registeredVoters",
    acks: "all",
    retryCount: 3
};

kafka:Producer kafkaProd = checkpanic new (ProdConfigs);

service graphql:Service /Application_API on new graphql:Listener(9090) {

    resource function get Apply(Record student) returns string {
        
        let response;

        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "voters",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending from the producer...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the producer records...";
        }

        return "Acknowledging voter registration...";
    }
} 

public type Student record {|
    string Fullname="";
    string studentNumber = "";
    Application stnd_Application = {};
|};

public type Application record {|
    int applicationNo = 0;
    string applicationStatus = "";
    
|} 