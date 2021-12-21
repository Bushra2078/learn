Strings are one of the most common method types in Python, you'll often need to manipulate them to extract information or fit a certain format. Python includes several string methods that are designed to do the most common and useful transformations.

String methods are part of the `str` type. This means that the methods exist as on a string variable, or part of the string directly. For example, the method `.title()` can be used with a string directly: 

```python
>>> "temperatures and facts about the moon".title()
'Temperatures And Facts About The Moon'
```

And the same behavior and usage happens on a variable:

```python
>>> heading = "temperatures and facts about the moon"
>>> heading.title()
'Temperatures And Facts About The Moon'
```

## Split a string

A common string method is `.split()`. With no arguments, it will split a string on every space, which creates a list of every item separated by a space:

```python
>>> temperatures = """Daylight: 260 F
... Nighttime: -280 F"""
>>> temperatures .split()
['Daylight:', '260', 'F', 'Nighttime:', '-280', 'F']
```

In this example, you're dealing with multiple lines, so the (implicit) newline character can be used to split at the end of each line, creating single lines:

```python
>>> temperatures .split('\n')
['Daylight: 260 F', 'Nighttime: -280 F']
```

This type of splitting becomes handy when you need a loop to process or extract information, or when you're loading data from a text file or another resource.

## Search for a string

Aside from using a loop, some string methods can look for content before processing, without the need for a loop. Let's assume we have two sentences that talk about temperatures on planets and moons, but we're interested only in temperatures related to our Moon. That is, if the sentences aren't talking about the Moon, they shouldn't be processed to extract information.

The simplest way to find whether a given word, character, or group of characters exists in a string is _without_ using a method:

```python
>>> "Moon" in "This text will describe facts and challenges with space travel"
False
>>> "Moon" in "This text will describe facts about the Moon"
True
```

An approach to finding and getting the position of a given word in a string is to use the `.find()` method:

```python
>>> temperatures = """Saturn has a daytime temperature of -170 degrees Celsius,
... while Mars has -28 Celsius."""
>>> temperatures.find("Moon")
-1
```

The `.find()` method returns a `-1` when the word isn't found, or it returns the index (the number representing the place in the string). This is how it would behave if you're searching for the word _Mars_:

```python
>>> temperatures.find("Mars")
65
```

`65` is the position where `"Mars"` appears in the string.

Another way to search for content is to use the `.count()` method, which returns the total number of occurrences of a certain word in a string:

```python
>>> temperatures.count("Mars")
1
>>> temperatures.count("Moon")
0
```

Strings in Python are case-sensitive, which means that *Moon* and *moon* are considered different words. To do a case-insensitive comparison, you can convert a string to all lowercase by using the `.lower()` method:

```python 
>>> "The Moon And The Earth".lower()
'the moon and the earth'
```

Similar to the `.lower()` method, strings have an `.upper()` method that does the opposite, converting every character to uppercase:

```python
>>> "The Moon And The Earth".upper()
'THE MOON AND THE EARTH'
```

> [!TIP]
> When you're searching for and checking content, a more robust approach is to lowercase a string so that casing doesn't prevent a match. For example, if you're counting the number of times the word *the* appears, the method wouldn't count the times where *The* appears, even though they're both the same word. You can use the `.lower()` method to change all characters to lowercase.

## Check content

There are times when you'll process text to extract information that's irregular in its presentation. For example, the following string is simpler to process than an unstructured paragraph: 

```python
>>> temperatures = "Mars Average Temperature: -60 C"
```

To extract the average temperature on Mars, you can do well with the following methods:

```python
>>> parts = temperatures.split(':')
>>> parts
['Mars average temperature', ' -60 C']
>>> parts[-1]
' -60 C'
```

The preceding methods blindly trust that everything after the colon (`:`) character is a temperature. The string is split at `:`, which produces a list of two items. Using `[-1]` on the list returns the last item, which is the temperature in this example.

If the text is irregular, you can't use the same splitting methods to get the value. You must loop over the items and check to see whether the values are of a certain type. Python has methods that help check the type of string:

```python
>>> mars_temperature = "The highest temperature on Mars is about 30 C"
>>> for item in mars_temperature.split():
...     if item.isnumeric():
...         print(item)
...
30
```

Similar to `.isnumeric()`, the `.isdecimal()` method can check for strings that look like decimals.

> [!IMPORTANT]
> It might be surprising to learn that `"-70".isnumeric()` would return `False`. This is because all characters in the string would need to be numeric, and the dash (`-`) isn't numeric. If you need to check negative numbers in a string, the `.isnumeric()` method wouldn't work.

There are extra validations that you can apply on strings to check for values. For negative numbers, the dash is prefixed to the number, and that can be detected with the `.startswith()` method:

```python
>>> "-60".startswith('-')
True
```

In a similar way, the `.endswith()` method helps with verifying the last character of a string:

```python
>>> if "30 C".endswith("C"):
    print("This temperature is in Celsius")
'This temperature is in Celsius'
```

## Transform text

There are other methods that help in situations where text needs to be transformed into something else. So far, you've seen strings that can use _C_ for _Celsius_ and _F_ for _Fahrenheit_. You can use the `.replace()` method to find and replace occurrences of a character or group of characters:

```python
>>> "Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius.".replace("Celsius", "C")
'Saturn has a daytime temperature of -170 degrees C, while Mars has -28 C.'
```

As already mentioned, `.lower()` is a good way to normalize text to do case-insensitive search. Let's quickly check to see whether some text is talking about the temperatures:

```python
>>> text = "Temperatures on the Moon can vary wildly."
>>> "temperatures" in text
False
>>> "temperatures" in text.lower()
True
```

You might not need to do case-insensitive verification all the time, but lowercasing every character is a good approach when text is using mixed casing. 

After you've split text and performed transformations, you might need to put all the parts back together again. Just as the `.split()` method can separate characters, the `.join()` method can put them back together. 

The `.join()` method requires an iterable (such as a Python list) as an argument, so its usage looks different from other string methods:

```python
>>> moon_facts = ["The Moon is drifting away from the Earth.", "On average, the Moon is moving about 4cm every year"]
>>> '\n'.join(moon_facts)
'The Moon is drifting away from the Earth.\nOn average, the Moon is moving about 4cm every year'
```

In this example, the newline character `'\n'` is used to join every item in the list.
