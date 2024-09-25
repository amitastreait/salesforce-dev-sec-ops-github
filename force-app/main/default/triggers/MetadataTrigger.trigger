trigger MetadataTrigger on Account (before insert) {
    for(Account acc: Trigger.New){
        System.debug(System.LoggingLevel.DEBUG, acc.Name);
    }
}