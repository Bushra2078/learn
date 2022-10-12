You'll now create a Spring Boot application that will receive messages from an Azure Service Bus queue.

## Create a Spring Boot project

Let's open up a new terminal window, and just like we did with the sender Spring Boot application, we'll use the [Spring Initializr](https://start.spring.io/) to create a Spring Boot project.

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web -d baseDir=spring-receiver-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Receive messages from a Service Bus queue

Here again, we'll add the dependency and configuration.

### Add the maven dependency for Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-receiver-application`, add the following command under dependencies:

```xml
            <dependency>
                <groupId>com.microsoft.azure</groupId>
                <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
                <version>2.3.3</version>
            </dependency>
```

### Add the configuration parameters

1. In the `spring-receiver-application\src\main\resources` folder, edit the `application.properties` file, add the following parameters:

    ```java
    server.port=9090
    
    spring.jms.servicebus.connection-string=<xxxxx>
    spring.jms.servicebus.idle-timeout=20000
    ```
2. Set the `spring.jms.servicebus.connection-string` property to the connection string to your Service Bus namespace, which you saved earlier.


### Add code to receive messages from Service Bus

Next, we'll add business logic to receive messages from a Service Bus queue.

In the directory `src/main/java/com/example/demo`, create a `ReceiveController.java` file that has the following content:

```java
package com.example.demo;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class ReceiveController {
    
    @JmsListener(destination = "test-queue-jms")
    public void receiveMessage(String message) {
        System.out.println("Received <" + message + ">");
    }
}
```

## Run the application locally

1. Switch back to the root of the sample `spring-receiver-application` folder where the `pom.xml` file is located, and run the following command to start your Spring Boot application. This step assumes that you have `mvn` installed on your Windows computer, and it's in the `PATH`. 

    ```bash
    mvn spring-boot:run
    ```
2. After the application startup completes, you'll see the following log statements in the console window.

    ```bash
    Received <Hello>
    Received <HelloAgain>
    Received <HelloOnceAgain>
    ```

    The appearance of the statements indicates that the Spring Boot application has successfully received messages from the Service Bus queue.

## See the entire workflow in action

If your sender application (from unit 4) is still running, you can select the following link to send a message to the Service Bus queue:

```html
http://localhost:8080/messages?message=HelloOnceAgainAndAgain
```

which will in turn be received by your receiver application and will be displayed in your console.

```bash
Received <HelloOnceAgainAndAgain>
```
