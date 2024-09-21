trigger AccountTrigger on Account (before insert) {
    /*Iterate over the list of records*/
    for(Account ACC: Trigger.New){
      acc.Description = 'Iterate over the list of records';
      acc.Industry = 'Education';
      //acc.Active__c = 'Yes';
      acc.Fax = '9874563210';
    }
    System.debug('This is a sample debug');
    for(Account acc: Trigger.New){
        System.debug('Account ID: ' + acc.Id);
    }
}