@IsTest
private class MockClass_Test {

    @IsTest
    static void expectCallsToMockedClass() {

        // Setup
        MockClass mock = new MockClass(ShopBackend.class)
                                .expects(new Call('initialize'))
                                .expects(new Call('hasInStock')
                                                .withParam('item', 'FizzBuzz')
                                                .returning(true));

        ShopBackend mockedBackend = (ShopBackend) mock.instance;


        // Exercise
        new Shop(mockedBackend).buy('FizzBuzz');


        // Verify
        System.assert(mock.verify(), mock);
    }
}