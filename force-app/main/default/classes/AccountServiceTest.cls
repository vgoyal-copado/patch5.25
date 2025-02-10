@IsTest
private class AccountServiceTest {
    
    @TestSetup
    static void setupTestData() {
        // Create {!Environment.my_var} accounts
        List<Account> {!Environment.my_var}Accounts = new List<Account>();
        
        // Enterprise account
        {!Environment.my_var}Accounts.add(new Account(
            Name = 'Test Enterprise Account',
            AnnualRevenue = 200000
        ));
        
        // Small revenue account
        {!Environment.my_var}Accounts.add(new Account(
            Name = 'Test Small Account',
            AnnualRevenue = 50000
        ));
        
        insert {!Environment.my_var}Accounts;
    }
    
    @IsTest
    static void {!Environment.my_var}UpdateAccountDescription_Enterprise() {
        // Get enterprise {!Environment.my_var} account
        Account enterpriseAcc = [SELECT Id FROM Account WHERE Name = 'Test Enterprise Account' LIMIT 1];
        
        Test.startTest();
        AccountService.updateAccountDescription(enterpriseAcc.Id);
        Test.stopTest();
        
        // Verify results
        Account updatedAcc = [SELECT Description FROM Account WHERE Id = :enterpriseAcc.Id];
        System.assertEquals('Enterprise Accounts', updatedAcc.Description, 
            'Enterprise account should have Enterprise Accounts description');
    }
    
    @IsTest
    static void {!Environment.my_var}UpdateAccountDescription_SmallRevenue() {
        // Get small revenue {!Environment.my_var} account
        Account smallAcc = [SELECT Id FROM Account WHERE Name = 'Test Small Account' LIMIT 1];
        
        Test.startTest();
        AccountService.updateAccountDescription(smallAcc.Id);
        Test.stopTest();
        
        // Verify results
        Account updatedAcc = [SELECT Description FROM Account WHERE Id = :smallAcc.Id];
        System.assertEquals('Small Revenue Accounts', updatedAcc.Description, 
            'Small revenue account should have Small Revenue Accounts description');
    }
    
    @IsTest
    static void {!Environment.my_var}UpdateAccountDescription_NullId() {
        Test.startTest();
        try {
            AccountService.updateAccountDescription(null);
            System.assert(false, 'Should have thrown an exception');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Account ID cannot be null', e.getMessage(), 
                'Should throw correct error message for null ID');
        }
        Test.stopTest();
    }
}