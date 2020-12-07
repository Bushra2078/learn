In this module, we'll use JavaServer Faces (JSF) as a "View" Technology to learn the basic concept of JSF.

## What is JavaServer Faces (JSF)

JSF was adopted as a specification in the Java Platform, Enterprise Edition (Java EE) as part of Java EE 5 (2006). Initially, JSF used Java Server Pages (JSP) to render HTML pages. Since version 2.0, Facelets, which is closer to ordinary HTML, has been used.

JSF is a component-based application Framework. Each component's state is saved depending on the client's interaction.
The state is saved when a new page is requested and is restored when returned.

### JSF basic functionality

JSF applications are roughly divided into the following two functions:

- **Facelets**: a XHTML-based template engine that describes screen layouts
- **BackingBean**: a Java class that binds to Facelets and sets and processes values

`Facelets` is an XHTML-based template engine that describes screen layouts, written by XHTML. XHTML conforms to the Document Type Definition (DTD) defined in W3C and is described as a file with a `xhtml` extension.

`BackingBean` is a Java Class linked a JSF Page. It contains Action methods, Action Listeners, and Value Change listeners.
In Java EE 6, Backing Beans were implemented with JSF-Managed Beans. Since Java EE 7, Context and Dependency Injection(CDI) beans are used as the implementation.

## Create a JSF page with PrimeFaces

PrimeFaces is a third-party JSF implementation that makes it easy to create JSF web components.
PrimeFaces is a lightweight library with one jar, zero-configuration, and no required dependencies. You just need to download PrimeFaces, add the primefaces-{version}.jar to your classpath and import the namespace to get started - `xmlns:p="http://primefaces.org/ui"`

Let's look at an example: In the below PrimeFaces page, the `p:outputLabel`,`p:inputText`, and `p:commandButton` tags are used to display labels, input fields, and buttons.

```xml
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:p="http://primefaces.org/ui" >
    <h:head>
        <title>Input Value Counter Sample</title>
    </h:head>
    <h:body>
        <h:form>
            <p:outputLabel value="Basic"/><br/>
            <p:inputText value="#{indexcontroller.inputValue}"/><br/>
            <p:commandButton value="Submit" action="#{indexcontroller.submitButtonAction()}"/><br/>
        </h:form>
    </h:body>
</html>
```

Writing the above XHTML code, the following screen will be displayed:

:::image type="content" source="../media/simple-javaserver-faces-facelets-primefaces-ajax.png" alt-text="JSF Facelets Sample":::

### PrimeFaces Ajax support

JSF supports Ajax applications by default. You can dynamically update a part of the screen without refreshing the screen.
PrimeFaces makes use of the `update` attribute to make it easier to implement the Ajax support provided by JSF. You specify which component should be updated with its target ID. In the example below, the `update ="ajaxUpdateText"` attribute is added to `p:commandButton`, so the `<div id ="ajaxUpdateText">` part is updated when the button is pressed. The `id` here can be specified for any HTML component.

```xml
<div id="ajaxUpdateText">
...
</div>

<p:commandButton update="ajaxUpdateText" 
   value="Submit" action="#{indexcontroller.submitButtonAction()}"/>
```

## JSF backing bean

Backing beans are Java classes that implement the backend processing associated with a JSF View.
In the next example, we'll reference a backing bean, `IndexController`, linked to the above XHTML. We'll use the `@Named` annotations to configure our JavaServer Faces applications so that it can be referenced from our JSF Facelets.

If you write `<p: inputText value ="#{indexcontroller.inputValue}"/>` in Facelets, the Input Text field will be displayed on the screen. The entered value is bound to the `inputValue` defined in the `IndexController` class.

Also, if you write `<p:commandButton value ="Submit" action="#{indexController.submitButtonAction()}"/>`, the HTML button will be displayed. When the button is pressed, it invokes the `submitButtonAction()` method defined in the `IndexController` class.

```java
import java.io.Serializable;

import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;

@Named("indexcontroller")
@ViewScoped
public class IndexController implements Serializable {

    private static final long serialVersionUID = 8485377386286855408L;

    @Setter @Getter
    private String inputValue;

    private int counter;

    public void submitButtonAction(){
        inputValue = inputValue + " : " + counter;
        counter++;
    }
}
```

In this way, JSF allows the View (Facelets) and Controller (Backing Bean) that make up the screen to be implemented separately.

In this section, we introduced JSF.  
In the next section, we'll create a JSF application and run it locally.
