@IsTest
public class HttpMock implements HttpCalloutMock {

    private static final String ANY_URL = null;

    private Map<String, Map<String, Object>> responses = new Map<String, Map<String, Object>>();


    // PUBLIC

    public HttpMock get(String url, Object body, Integer statusCode) {
        return mock('GET', url, body, statusCode);
    }


    public HttpMock get(String url, Object body) {
        return get(url, body, 200);
    }


    public HttpMock get(Object body, Integer statusCode) {
        return get(ANY_URL, body, 200);
    }


    public HttpMock post(String url, Object body, Integer statusCode) {
        return mock('POST', url, body, statusCode);
    }


    public HttpMock post(String url, Object body) {
        return post(url, body, 200);
    }


    public HttpMock post(Object body, Integer statusCode) {
        return post(ANY_URL, body, 200);
    }


    public HttpMock put(String url, Object body, Integer statusCode) {
        return mock('PUT', url, body, statusCode);
    }


    public HttpMock put(String url, Object body) {
        return put(url, body, 200);
    }


    public HttpMock put(Object body, Integer statusCode) {
        return put(ANY_URL, body, 200);
    }


    public void mock() {
        Test.setMock(HttpCalloutMock.class, this);
    }


    // implements HttpCalloutMock

    public HttpResponse respond(HttpRequest request) {
        HttpResponse result = badRequest();

        String method = request.getMethod();

        if(responses.containsKey(method)) {
            for(String url : responses.get(method).keySet()) {
                if(url == ANY_URL || request.getEndpoint().containsIgnoreCase(url)) {
                    Object response = responses.get(method).get(url);

                    if(response instanceof Exception) {
                        throw (Exception) response;
                    }
                    else {
                        result = (HttpResponse) response;
                    }

                    break;
                }
            }
        }

        return result;
    }

    // PRIVATE

    private HttpMock mock(String method, String url, Object body, Integer statusCode) {
        if(!responses.containsKey(method)) {
            responses.put(method, new Map<String, Object>());
        }

        if(body instanceof Exception) {
            responses.get(method).put(url, body);
        }
        else {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setStatusCode(statusCode);
            response.setBody(JSON.serialize(body));

            responses.get(method).put(url, response);
        }

        return this;
    }


    private HttpMock mock(String method, String url, Object body) {
        return mock(method, url, body, 200);
    }


    private HttpMock mock(String method, Object body, Integer statusCode) {
        return mock(method, ANY_URL, body, 200);
    }


    private HttpResponse badRequest() {
        HttpResponse result = new HttpResponse();
        result.setStatusCode(500);
        result.setStatus('Invalid Request');
        result.setBody('{}');
        return result;
    }
}