Immersive Reader can be integrated into applications using the **JavaScript SDK**. To use Immersive Reader, you must create an Immersive Reader resource and configure Azure Active Directory (Azure AD) authentication. Quickstarts and advanced samples for how to set up Immersive Reader with languages such as Python, C#, Java, and Node.js are available in Unit 7 - Summary.

## Embedding Immersive Reader

Immersive Reader can be embedded into applications using the client library, which displays Immersive Reader on top of your existing web application in an iframe. The following example adds the client library into HTML:

```HTML
    <script src="https://contentstorage.onenote.office.net/onenoteltir/immersivereadersdk/immersive-reader-sdk.1.0.0.js"></script>
```

**The client library supplies a button to launch Immersive Reader** with content on the webpage. You can add custom styling to the button, choose which content Immersive Reader interacts with, and specify the language with an ‘_id_’ tag in the HTML.

## Enhancing readability and concentration

The `launchAsync` command starts Immersive Reader with your selected content, and has an option parameter to select a number of features:

* **Spacing and Font Sizes** improve reading speed by addressing "visual crowding"
* **Words can be broken into syllables** to improve readability or to sound out new words
* Parts of Speech and grammar can be highlighted to help learners understand verbs, nouns, pronouns, and more
* **Colors** can be selected for different parts of speech to increase understanding and reading ease
* **Line focus** shows only one, three or fives lines at a time, depending on your needs
* **Focus mode** only shows the text, taking away outside distractions
* **Picture dictionaries** aid reading and comprehension through multi-sensory processing--the ability to see a picture and hear a word simultaneously

```JavaScript
const options = {
    readAloudOptions: {
        autoplay: true,
        voice: 'female',
        speed: 1.5
    },
    translationOptions: {
        language: 'fr-FR',
        autoEnableDocumentTranslation: true
    },
    displayOptions: {
        textSize?: 20,
        increaseSpacing?: true
    }
};

ImmersiveReader.launchAsync(YOUR_TOKEN, YOUR_SUBDOMAIN, data, YOUR_OPTIONS);
```

## Math equation support

Math can be supplied to Immersive Reader in HTML when the MIME type is set to `application/mathml+xml`. For example, the following JavaScript finds HTML elements that use the id `ir-content`, and displays them as Math by setting the mimeType to 'application/mathml+xml':

```JavaScript
const data = {
    title: 'My Math',
    chunks: [{
        content: document.getElementById('ir-content').innerHTML.trim(),
        mimeType: 'application/mathml+xml'
    }]
};

ImmersiveReader.launchAsync(YOUR_TOKEN, YOUR_SUBDOMAIN, data, YOUR_OPTIONS);
```

![Math output](../media/1-math.png)

## Using on mobile

Microsoft Lens—formerly Microsoft Office Lens—is an Android and iOS app that trims, enhances, and makes pictures of whiteboards and documents readable. Immersive Reader can be used through Microsoft Lens, allowing the user to apply the read aloud, text spacing, and color changing functions to the document, creating greater accessibility and equity for all readers, no matter where they are.
