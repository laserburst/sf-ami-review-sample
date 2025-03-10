public class InsecureApexClass {

    // Hardcoded credentials (Insecure)
    private static final String USERNAME = 'admin';
    private static final String PASSWORD = 'password123';

    // SOQL Injection (Insecure)
    public static List<Account> getAccounts(String userInput) {
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + userInput + '%\'';
        return Database.query(query);
    }

    // Unrestricted Query (Insecure)
    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    // Hardcoded Ids (Anti-pattern)
    public static Account getAccountById() {
        return [SELECT Id, Name FROM Account WHERE Id = '001xx000003DGbYAAW'];
    }

    // DML inside a loop (Anti-pattern)
    public static void updateAccounts(List<Account> accounts) {
        for (Account acc : accounts) {
            acc.Name = 'Updated Name';
            update acc;
        }
    }

    // SOQL inside a loop (Anti-pattern)
    public static void processContacts(List<Id> accountIds) {
        for (Id accountId : accountIds) {
            List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
            for (Contact contact : contacts) {
                contact.Description = 'Processed';
                update contact;
            }
        }
    }

    // Unhandled exceptions (Insecure)
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

    // Excessive use of static variables (Anti-pattern)
    public static Integer counter = 0;

    public static void incrementCounter() {
        counter++;
    }

    // Unrestricted CRUD/FLS (Insecure)
    public static void createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
    }

    // Inefficient bulk processing (Anti-pattern)
    public static void inefficientBulkProcessing(List<Account> accounts) {
        for (Account acc : accounts) {
            acc.Name = 'Bulk Updated Name';
        }
        update accounts;
    }

    // Hardcoded URLs (Insecure)
    public static void callExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://example.com/api');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}