/**
 * @description Insecure Apex class demonstrating several security anti-patterns.
 */
public class InsecureApexClass {

    // Hardcoded credentials (Insecure)
    private static final String USERNAME = 'admin';
    private static final String PASSWORD = 'password123';

    /**
     * @description Retrieves a list of accounts based on user input.
     * @param userInput The name to search for in the Account's Name field.
     * @return List<Account> A list of matching Account records.
     */
    public static List<Account> getAccounts(String userInput) {
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + userInput + '%\'';
        return Database.query(query);
    }

    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    /**
     * @description Retrieves an Account record by its Id.
     * @return Account The Account record corresponding to the hardcoded Id.
     */
    public static Account getAccountById() {
        return [SELECT Id, Name FROM Account WHERE Id = '001xx000003DGbYAAW'];
    }

    /**
     * @description Updates a list of Account records.
     * @param accounts A list of Account records to update.
     */
    public static void updateAccounts(List<Account> accounts) {
        for (Account acc : accounts) {
            acc.Name = 'Updated Name';
            update acc;
        }
    }

    /**
     * @description Processes contacts associated with the given account IDs.
     * @param accountIds A list of account IDs whose contacts will be processed.
     */
    public static void processContacts(List<Id> accountIds) {
        for (Id accountId : accountIds) {
            List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
            for (Contact contact : contacts) {
                contact.Description = 'Processed';
                update contact;
            }
        }
    }
    
    /**
     * @description Handles the processing of a list of Account records with potential error handling.
     * @param accounts A list of Account records to process.
     */
    public static void processAccounts(List<Account> accounts) {
        for (Account acc : accounts) {
            try {
                // Some processing logic
                Integer result = 10 / 0; // This will cause a divide by zero exception
            } catch (Exception e) {
                // Do nothing
            }
        }
    }

    /**
     * @description Creates a new Account with the specified name.
     * @param name The name of the Account to create.
     */
    public static void createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
    }

    /**
     * @description Calls an external service with a hardcoded endpoint.
     */
    public static void callExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://example.com/api');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}