public class AccountService {
/**
 * @description Updates Account descriptions based on Annual Revenue threshold
 * @param accountId The ID of the Account to update
 */
public static void updateAccountDescription(Id accountId) {
    // Guard clause for null input
    if (accountId == null) {
        throw new IllegalArgumentException('Account ID cannot be null');
    }
    
    try {
        // Query account with required fields
        Account acc = [
            SELECT Id, AnnualRevenue, Description 
            FROM Account 
            WHERE Id = :accountId
            LIMIT 1
        ];
        
        // Set description based on annual revenue
        if (acc.AnnualRevenue != null && acc.AnnualRevenue > 100000) {
            acc.Description = 'Enterprise Accounts';
        } else {
            acc.Description = 'Small Revenue Accounts';
        }
        
        // Update the account
        update acc;
        
    } catch (QueryException qe) {
        throw new AccountServiceException('Account not found: ' + accountId);
    } catch (DmlException de) {
        throw new AccountServiceException('Error updating account: ' + de.getMessage());
    }
}
    
    public static List<Account> getAccountsWithRevenue(Decimal minRevenue) {
        return [SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue >= :minRevenue];
    }


/**
 * @description Custom exception class for Account Service
 */
public class AccountServiceException extends Exception {}
}