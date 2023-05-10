package skarab;


import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class LambdaHandler implements RequestHandler<Request, Response> {


    public LambdaHandler() {

    }

    public Response handleRequest(Request request, Context context) {
        final String name = request.getName();
        final String currentLocation = System.getenv("currentLocation");
        return new Response(String.format("Hello %s from %s", name, currentLocation));
    }
}