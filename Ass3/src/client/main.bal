import ballerina/io;


kafka:ProducerConfiguration prodConfig ={
bootstrapServers:"localhost:9092",
clientId: "registeredVoters",
acks:"all",
retryCount:3
};

kafka:Producer kafkaProducer = new (prodConfig);

public function main() {
   Student s1 = {
    Fullname :"Willy Wonker", 
    StudentNumber : "219070318",  
    
   };
   apply(s1);
}


function apply(Student newStudentEntry) returns Student {


    var result = kafkaProducer->Apply(newStudentEntry);

    if (result is kafka:ProducerError) {

        io:println("An Error [!] => ", result.toString());

        return newStudentEntry;

    } else {

        savedResponse response = result[0];

        AlbumEntries e = {BandName: newStudentEntry["RecordBand"], AlbumName: newStudentEntry["RecordName"], HASHKey: response.RecordKey};
        MyMusic.push(e);

        newStudentEntry.Key = response.RecordKey;
        io:println(newStudentEntry.Key);
        return newStudentEntry;

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