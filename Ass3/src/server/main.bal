import ballerina/io;
import ballerina/graphql;
import ballerinax/kafka;


kafka:ProducerConfiguration ProdConfigs = {
    bootstrapServers: "localhost:9092",
    clientId: "registeredVoters",
    acks: "all",
    retryCount: 3
};

kafka:Producer kafkaProd = checkpanic new (ProdConfigs);

//Application Service For Applying and setting up interview with prospective students
service graphql:Service /Application_API on new graphql:Listener(9090) {

    resource function get Apply(Record student) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
    }

    resource function get setInterview(Record student) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
    }

}


service graphql:Service /Proposal_API on new graphql:Listener(9090) {

    resource function post Submit(Record proposal) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
    }

    resource function post PropsalApproval(Record proposal, Record HOD) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
    }

}

service graphql:Service /Thesis_API on new graphql:Listener(9090) {

    resource function post registration(Record Thesis) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
    }

    resource function post report(Record Thesis, Record FIE) returns string {
        
        let response;
        
        kafka:ProducerError? sendRes = kafkaProd->sendProducerRecord({topic: "studentApplicationManagement",
                                value: msg.toBytes() });
        if (sendRes is error) {
            return "An error occurred while sending a response...";
        }

        kafka:ProducerError? flushRes = kafkaProd->flushRecords();
        if (flushRes is error) {
            return "An error occurred while flushing the records...";
        }

        return "Acknowledging Student Statues...";
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
    
|};

public type proposal record {|
    string studentNo =  "";
    string statues = "";

|};

public type HOD record {|
    string HOD_ID  = "";
    string HOD_FullName = "";
    
|};

public type FIE record {|
    string FIE_ID  = "";
    string FIE_FullName = "";
    
|};