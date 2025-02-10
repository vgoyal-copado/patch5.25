public class ApexClass1 {
    
    public static void method1() {
        Account acc = [Select id, name from Account Limit 1];
        acc.name = 'ac1234 - 29 aug - 25 Nov';
        update acc;
    }

}