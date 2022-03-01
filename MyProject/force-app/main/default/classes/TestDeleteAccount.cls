/**
 * Created by akotiun on 01.03.2022.
 */
@IsTest
public class TestDeleteAccount {
    public static final String accountName = 'TesAcc';
    public static final String opportunityName = 'TestOpp';

    public static final String accountNameWithoutOpp = 'TesAcc2';
    @TestSetup
    private static void testSetup(){
        Account newAccount = TEST_DataFactory.createTestAccount(accountName);
        TEST_DataFactory.createTestOpportunity(newAccount, opportunityName);
        TEST_DataFactory.createTestAccount(accountNameWithoutOpp);
    }

    @IsTest
    private static void beforeDeleteTest(){
        Account acc = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
        Account accWithoutOpp = [SELECT Id FROM Account WHERE Name = :accountNameWithoutOpp LIMIT 1];

        Database.DeleteResult result;
        Database.DeleteResult resultSuccess;

        Test.startTest();
            result = Database.delete(acc, false);
            resultSuccess = Database.delete(accWithoutOpp, true);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(resultSuccess.isSuccess());
    }


}