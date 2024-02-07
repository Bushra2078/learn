Message routing enables users to route different data types namely, device telemetry messages, device lifecycle events, and device twin change events to various endpoints. You can also apply rich queries to this data before routing it to receive the data that matters to you.

Message routing allows you to query on the message properties and message body as well as device twin tags and device twin properties. If the message body is not JSON, message routing can still route the message, but queries cannot be applied to the message body. Queries are described as Boolean expressions where a Boolean true makes the query succeed which routes all the incoming data, and Boolean false fails the query and no data is routed. If the expression evaluates to null or undefined, it is treated as false and an error will be generated in diagnostic logs if there is a routing failure. The query syntax must be correct for the route to be saved and evaluated.

## Message routing query based on message properties

The Azure IoT Hub defines a common format for all device-to-cloud messaging for interoperability across protocols. Azure IoT Hub message assumes the following JSON representation of the message. System properties are added for all users and identify content of the message. Users can selectively add application properties to the message. We recommend using unique property names as Azure IoT Hub device-to-cloud messaging is not case-sensitive. For example, if you have multiple properties with the same name, Azure IoT Hub will only send one of the properties.

```json
{ 
  "message": { 
    "systemProperties": { 
      "contentType": "application/json", 
      "contentEncoding": "UTF-8", 
      "iothub-message-source": "deviceMessages", 
      "iothub-enqueuedtime": "2017-05-08T18:55:31.8514657Z" 
    }, 
    "appProperties": { 
      "processingPath": "{cold | warm | hot}", 
      "verbose": "{true, false}", 
      "severity": 1-5, 
      "testDevice": "{true | false}" 
    }, 
    "body": "{\"Weather\":{\"Temperature\":50}}" 
  } 
} 

```

### System properties

System properties help identify contents and source of the messages.

As described in [IoT Hub Messages](/azure/iot-hub/iot-hub-devguide-messages-construct), there are other system properties in a message. In addition to `contentType`, `contentEncoding`, and `enqueuedTime`, the `connectionDeviceId` and `connectionModuleId` properties can also be queried.

### Application properties

Application properties are user-defined strings that can be added to the message. These fields are optional.

### Query expressions for message routing query based on message properties

A query on message system properties needs to be prefixed with the `$` symbol. Queries on application properties are accessed with their name and should not be prefixed with the `$` symbol. If an application property name begins with `$`, then Azure IoT Hub will search for it in the system properties, and it is not found, then it will look in the application properties. For example:

To query on system property contentEncoding

```SQL
$contentEncoding = 'UTF-8'

```

To query on application property processingPath:

```SQL
processingPath = 'hot'

```

To combine these queries, you can use Boolean expressions and functions:

```SQL
$contentEncoding = 'UTF-8' AND processingPath = 'hot'

```

A full list of supported operators and functions is shown in Expression and conditions: [IoT Hub query language for device and module twins, jobs, and message routing](/azure/iot-hub/iot-hub-devguide-query-language).

## Message routing query based on message body

To enable querying on message body, the message should be in a JSON encoded in either UTF-8, UTF-16 or UTF-32. The `contentType` must be set to `application/JSON` and `contentEncoding` to one of the supported UTF encodings in the system properties. If these properties are not specified, Azure IoT Hub will not evaluate the query expression on the message body.

The following example shows how to create a message with a properly formed and encoded JSON body:

```javascript
var messageBody = JSON.stringify(Object.assign({}, {
    "Weather": {
        "Temperature": 50,
        "Time": "2017-03-09T00:00:00.000Z",
        "PrevTemperatures": [
            20,
            30,
            40
        ],
        "IsEnabled": true,
        "Location": {
            "Street": "One Microsoft Way",
            "City": "Redmond",
            "State": "WA"
        },
        "HistoricalData": [
            {
                "Month": "Feb",
                "Temperature": 40
            },
            {
                "Month": "Jan",
                "Temperature": 30
            }
        ]
    }
}));

// Encode message body using UTF-8  
var messageBytes = Buffer.from(messageBody, "utf8");

var message = new Message(messageBytes);

// Set message body type and content encoding 
message.contentEncoding = "utf-8";
message.contentType = "application/json";

// Add other custom application properties   
message.properties.add("Status", "Active");

deviceClient.sendEvent(message, (err, res) => {
    if (err) console.log('error: ' + err.toString());
    if (res) console.log('status: ' + res.constructor.name);
});

```

### Query expressions for message routing query based on message body

A query on message body needs to be prefixed with the $body. You can use a body reference, body array reference, or multiple body references in the query expression. Your query expression can also combine a body reference with message system properties, and message application properties reference. For example, the following are all valid query expressions:

```SQL
$body.Weather.HistoricalData[0].Month = 'Feb'

```

```SQL
$body.Weather.Temperature = 50 AND $body.Weather.IsEnabled

```

```SQL
length($body.Weather.Location.State) = 2 

```

```SQL
$body.Weather.Temperature = 50 AND processingPath = 'hot' 

```

## Message routing query based on device twin

Message routing enables you to query on Device Twin tags and properties, which are JSON objects. Querying on module twin is not supported. A sample of Device Twin tags and properties is shown below.

```json
{
    "tags": { 
        "deploymentLocation": { 
            "building": "43", 
            "floor": "1" 
        } 
    }, 
    "properties": { 
        "desired": { 
            "telemetryConfig": { 
                "sendFrequency": "5m" 
            }, 
            "$metadata" : {...}, 
            "$version": 1 
        }, 
        "reported": { 
            "telemetryConfig": { 
                "sendFrequency": "5m", 
                "status": "success" 
            },
            "batteryLevel": 55, 
            "$metadata" : {...}, 
            "$version": 4 
        } 
    } 
} 

```

### Query expressions for message routing query based on device twin

A query on device twin properties needs to be prefixed with the `$twin`. Your query expression can also combine a twin tag or property reference with a body reference, message system properties, and message application properties reference. We recommend using unique names in tags and properties as the query is not case-sensitive. Also refrain from using twin, `$twin`, body, or `$body`, as a property names. For example, the following are all valid query expressions:

```SQL
$twin.properties.desired.telemetryConfig.sendFrequency = '5m'

```

```SQL
$body.Weather.Temperature = 50 AND $twin.properties.desired.telemetryConfig.sendFrequency = '5m'

```

```SQL
$twin.tags.deploymentLocation.floor = 1 

```
