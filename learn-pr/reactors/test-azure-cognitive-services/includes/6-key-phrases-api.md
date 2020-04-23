> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needa Input and Output code, and Hint text. Search on TBD.
> - Need output cell content. Search on TBD.
>

We've detected the language type using the Text Analytics API and the sentiment using the Sentiment Analysis API. What if we want to detect key phrases in the text? We can use the Key Phrase API.

```python
# As with the other services, setup the Key Phrases API with the following parameters
key_phrase_api_url = text_analytics_base_url + "keyPhrases"
print(key_phrase_api_url)
```

The output is:

```Output
TBD
```

Create the documents needed to pass to the Key Phrases API with the `id` and `text` attributes.

```python
documents = {'documents' : [
  {'id': '1', 'language': 'en', 'text': 'I had a wonderful experience! The rooms were wonderful and the staff was helpful.'},
  {'id': '2', 'language': 'en', 'text': 'I had a terrible time at the hotel. The staff was rude and the food was awful.'},  
  {'id': '3', 'language': 'es', 'text': 'Los caminos que llevan hasta Monte Rainier son espectaculares y hermosos.'},  
  {'id': '4', 'language': 'es', 'text': 'La carretera estaba atascada. Había mucho tráfico el día de ayer.'}
]}
```

Here's the output:

```Output
TBD
```

Now, call the Key Phrases API with the formatted documents to retrieve the key phrases.

```python
headers   = {'Ocp-Apim-Subscription-Key': subscription_key}
response  = requests.post(key_phrase_api_url, headers=headers, json=documents)
key_phrases = response.json()
pprint(key_phrases)
```

The output is:

```Output
TBD
```

We can make this easier to read by outputing the documents in an HTML table format.

```python
table = []
for document in key_phrases["documents"]:
    text    = next(filter(lambda d: d["id"] == document["id"], documents["documents"]))["text"]    
    phrases = ",".join(document["keyPhrases"])
    table.append("<tr><td>{0}</td><td>{1}</td>".format(text, phrases))
HTML("<table><tr><th>Text</th><th>Key phrases</th></tr>{0}</table>".format("\n".join(table)))
```

Here's the output:

```Output
TBD
```

Now call the Key Phrases API with the formatted documents to retrive the key phrases.

### Try it yourself

What other key phrases can you come up with for analysis?

<br />

<details> 

  <summary>Hint - TBD <i>(expand to reveal)</i></summary>

  ```python
  tbd
  ```

  ```Output
  tbd
  ```
  
</details>

<br /><br />

***
