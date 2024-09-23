@IsTest
public class SlackWebhookListenerTest {
    @IsTest
    static void testDoPost() {
        // Create a test Slack_App__c record
        Slack_App__c slackApp = new Slack_App__c(
            App_Id__c = 'TEST_APP_ID',
            App_Signature__c = 'TEST_APP_SIGNATURE'
        );
        //insert slackApp;
        insert slackApp;
        // Set up a mock RestRequest and RestResponse
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/v1/slack';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{"event_context": "test_event"}');
        req.headers.put('X-Slack-Signature', 'TEST_APP_ID:TEST_APP_SIGNATURE');
        req.headers.put('X-Slack-Request-Timestamp', '1234567890');

        RestContext.request = req;
        RestContext.response = res;

        // Call the doPost method of the SlackWebhookListener class
        SlackWebhookListener.doPost();

        // Verify the expected behavior
        // For example, you can query the Slack_App__c record to ensure it was updated correctly
        slackApp = [SELECT Id, App_Signature__c FROM Slack_App__c WHERE Id = :slackApp.Id];
        System.assertEquals('TEST_APP_SIGNATURE', slackApp.App_Signature__c, 'The app signature should be updated');
    }
}