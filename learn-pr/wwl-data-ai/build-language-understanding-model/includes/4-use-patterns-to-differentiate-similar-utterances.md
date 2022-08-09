In some cases, a model might contain multiple intents for which utterances are likely to be similar. You can use the pattern of utterances to disambiguate the intents while minimizing the number of sample utterances.

For example, consider the following utterances:

- "Turn the kitchen light on."
- "Is the kitchen light on?"
- "Turn the kitchen light off."

These utterances are syntactically similar, with only a few differences in words or punctuation. However, they represent three different intents (which could be named **TurnOnDevice**, **GetDeviceStatus**, and **TurnOffDevice**). Additionally, the intents could apply to a wide range of entity values. In addition to "kitchen light", the intent could apply to "living room light", "bedside lamp", "fan", television", or any other device that the model might need to support.

To correctly train your model, provide a handful of examples of each intent that specify the different formats of utterances.

- **TurnOnDevice**:
    - "Turn the {DeviceName} on."
    - "Switch the {DeviceName} on."
    - "Turn on the {DeviceName}."
- **GetDeviceStatus**:
    - "Is the {DeviceName} on[?]"
- **TurnOffDevice**:
    - "Turn the {DeviceName} off."
    - "Switch the {DeviceName} off."
    - "Turn off the {DeviceName}."

By teaching your model with each different type of utterance, the Language service can learn how to categorize intents correctly based off format and punctuation.
