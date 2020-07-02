@TestVisible
public class Call {

    private String method;
    private List<Parameter> expectedParams = new List<Parameter>();
    public Object returnValue;


    public Call(String method) {
        this.method = method;
    }


    public Call param(Type type, Object value) {
        expectedParams.add(new Parameter(type, value));
        return this;
    }


    public Call returning(Object value) {
        returnValue = value;
        return this;
    }


    public void validate(String method, List<Type> paramTypes, List<Object> paramValues) {
        System.assertEquals(this.method, method, 'Method not expected');

        List<Parameter> actualParams = asParameters(paramTypes, paramValues);
        System.assertEquals(expectedParams.size(), actualParams.size(), 'Parameters not expected');

        for(Integer i=0; i<actualParams.size(); i++) {
            Parameter actual = actualParams[i];
            Parameter expected = expectedParams[i];

            System.assertEquals(expected.type, actual.type, 'Type not expected: ' + actual.type);
            System.assertEquals(expected.value, actual.value, 'Value not expected' + actual.value);
        }
    }


    // PRIVATE

    private List<Parameter> asParameters(List<Type> types, List<Object> values) {
        System.assertEquals(types.size(), values.size(), 'Type Value mismatch');

        List<Parameter> result = new List<Parameter>();

        for(Integer i=0; i<types.size() ; i++) {
            result.add( new Parameter(types[i], values[i]) );
        }

        return result;
    }


    // INNER

    private class Parameter {
        private Type type;
        private Object value;

        private Parameter(Type type, Object value) {
            this.type = type;
            this.value = value;
        }
    }
}