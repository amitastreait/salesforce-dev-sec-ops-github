trigger AccountTrigger on Account (before insert) {
    System.debug('This is a sample debug');
    for(Account acc: Trigger.New){
        System.debug('Account ID: ' + acc.Id);
    }
}