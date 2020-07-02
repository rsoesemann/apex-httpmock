public class MockClass implements StubProvider {

    private Object instance;
    private List<Call> expectedCalls = new List<Call>();


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


    public Object instance() {
        return instance;
    }


    // implements StubProvider

    public Object handleMethodCall(Object stubbedObject, String method, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> paramValues) {
        System.assert(!expectedCalls.isEmpty(), 'Didnt expect any call.');

        Call expectedCall = expectedCalls.remove(0);
        expectedCall.validate(method, paramTypes, paramValues);

        return expectedCall.returnValue;
    }
}