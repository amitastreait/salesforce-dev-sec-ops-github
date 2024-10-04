@RestResource(urlMapping='/v1/slack/*')
global without sharing class SlackWebhookListener {
    
    @HttpPost
    global static void doPost(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Blob body = req.requestBody;
        String requestString = body.toString();
        // Get the request headers
        Map<String, String> headers = req.headers;

        // Get the Slack signature from the header
        String slackSignature = headers.get('X-Slack-Signature');

        // Create a new Slack_App record with the app_id and app_signature from the slackSignature
        String appId = slackSignature.substringBefore(':');
        String appSignature = slackSignature.substringAfter(':');

        Slack_App__c slackApp = new Slack_App__c(
            App_Id__c = appId,
            App_Signature__c = appSignature
        );

        // Calculate the request_timestamp and request_signature using the slackApp record
        Long requestTimestamp = Long.valueOf(headers.get('X-Slack-Request-Timestamp'));
        String requestSignature = generateRequestSignature(slackApp, requestTimestamp, requestString);

        // Compare the request_signature with the slackSignature
        if (requestSignature.equals(slackSignature)) {
            System.System.debug(System.LoggingLevel.DEBUG, 'Signagure verified');
        } else {
            System.System.debug(System.LoggingLevel.WARN, 'Signagure Not verified');
        }
    }

    private static String generateRequestSignature(Slack_App__c slackApp, Long requestTimestamp, String requestString) {
        String appSignature = slackApp.App_Signature__c;
        String requestTimestampString = String.valueOf(requestTimestamp);
    
        // Convert the app_signature and request_timestamp to Blob
        Blob appSignatureBlob = Blob.valueOf(appSignature);
        Blob requestTimestampBlob = Blob.valueOf(requestTimestampString);
    
        // Generate a hash of the request_string using the app_signature and request_timestamp
        Blob requestSignatureBlob = Crypto.generateMac('HmacSHA256', Blob.valueOf(requestString), appSignatureBlob );
    
        // Convert the request_signature to a hexadecimal string
        String requestSignature = EncodingUtil.convertToHex(requestSignatureBlob);
    
        return requestSignature;
    }     

}