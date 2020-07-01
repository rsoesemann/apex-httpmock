@TestVisible
public class Call {

    private String method;
    private Map<String, Object> expectedParams = new Map<String, Object>();
    public Object returnValue;


    public Call(String method) {
        this.method = method;
    }


    public Call withParam(String name, Object value) {
        expectedParams.put(name, value);
        return this;
    }


    public Call returning(Object value) {
        returnValue = value;
        return this;
    }


    public void validate(String method, List<String> paramNames, List<Object> paramValues) {
        System.assertEquals(this.method, method, 'Method not expected: ' + method);

        Map<String, Object> actualParams = asMap(paramNames, paramValues);

        for(String param : actualParams.keySet()) {
            System.assert(expectedParams.containsKey(param), 'Parameter not expected: ' + param);
            System.assertEquals(expectedParams.get(param), actualParams.get(param), 'Value not expected: ' + actualParams.get(param));
        }
    }


    // PRIVATE

    private Map<String, Object> asMap(List<String> keys, List<Object> values) {
        System.assertEquals(keys.size(), values.size(), this);

        Map<String, Object> result = new Map<String, Object>();

        for(Integer i=0; i<keys.size() ; i++) {
            result.put(keys[i], values[i]);
        }

        return result;
    }
}