public class MockClass implements StubProvider {

    private List<Call> expectedCalls = new List<Call>();

    public Object instance { get; private set; }


    // CONSTRUCTOR

    public MockClass(Type mockedClass) {
        instance = Test.createStub(mockedClass, this);
    }

    // PUBLIC

    public MockClass expects(Call call) {
        expectedCalls.add(call);
        return this;
    }


    public Boolean verify() {
        return (expectedCalls.isEmpty());
    }


    // implements StubProvider

    public Object handleMethodCall(Object stubbedObject, String method, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> paramValues) {
        System.assert(!expectedCalls.isEmpty(), 'Didnt expect any call.');
System.debug(LoggingLevel.ERROR, expectedCalls);
System.debug(LoggingLevel.ERROR, method);

        Call expectedCall = expectedCalls.remove(0);

        expectedCall.validate(method, paramNames, paramValues);

        return expectedCall.returnValue;
    }
}