Keyword dictionaries are an efficient way to manage large lists of words that are regularly subject to change. Although you can create keyword lists in sensitive information types, keyword lists are limited in size and require modifying XML to create or edit them. Keyword dictionaries provide simpler management of keywords and at a much larger scale, supporting up to 100 KB of terms after compression in the dictionary and support of any language.

The source for keyword dictionaries can be several kinds of cleartext files, such as .txt and .csv files. Configuration of keyword dictionaries can be completed from the Microsoft 365 Compliance Center and via the Security & Compliance Center PowerShell module.

For detailed instructions see [Create a keyword dictionary](https://docs.microsoft.com/microsoft-365/compliance/create-a-keyword-dictionary?view=o365-worldwide).

## Keyword Dictionary Creation Best Practices

Consider the following a best practice to create your initial source keyword dictionary:

- For a school, you can get together with a class of students to find words and phrases you don't want in an education environment.

- For companies, you can use various options to collect:

  - Collect typical words from some departments, using Microsoft Forms

  - Collaborate with some employees for example, from HR or legal to create a list of typical words.

  - Create an employee audit and create the list out of the outcome.

  - ​ Remember that you can edit the list, so you can improve your results by revising them regularly.

## Keyword Dictionary Management

After creating a new keyword dictionary and using it in a policy, the keywords can be modified in case your requirements have changed. For example, a keyword dictionary used to detect disease classifications in medical data or for other static keywords required for policies.

For detailed steps see [Modifying an existing keyword dictionary](https://docs.microsoft.com/microsoft-365/compliance/create-a-keyword-dictionary?view=o365-worldwide).

## Keyword Dictionary as a Custom Sensitive Information Type

Keyword dictionaries can be used in rule package definitions for a custom sensitive information type. They can be selected as sensitive information types when creating policies in the Microsoft 365 Compliance Center or via the Security & Compliance Center PowerShell module. When using the PowerShell module, the keyword dictionary must be specified with its ID.

For detailed instructions see [Create a keyword dictionary from a file using PowerShell](https://docs.microsoft.com/microsoft-365/compliance/create-a-keyword-dictionary?view=o365-worldwide).

