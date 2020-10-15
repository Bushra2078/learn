Imagine you're a professional web developer and your client is a travel agency. To motivate its customers to stay in touch, the agency wants its website to include a service that translates road signs and billboards in real time. The customer, exploring a foreign land, snaps a picture of a sign they can't read, in a language they don't understand. The customer uploads the picture to the service, and it responds with a translation in the customer's native language. No typing, no forms to fill out—just "Here's a picture, tell me what it says."

To meet the client's requests, the website must support the following features:

- Photo uploads
- Extracting text from uploaded photos
- Translating extracted text into the user's language

Just a few years ago, such a feature list would have been unthinkable for most small businesses. Extracting text from photos and translating text into other languages is typically performed through machine learning and artificial intelligence (AI). Where would these capabilities come from? Today, these features and more are readily available in Azure Cognitive Services. Cognitive Services is the Microsoft portfolio of more than 20 services and APIs that are designed to make AI and machine learning available to anyone who can write a few lines of code.

One of these services is the Computer Vision API that analyzes photos to extract text and identify objects. The API can isolate faces in a photo to predict age, gender, and other information. Another service is the Translator Text API. The Translator Text API can translate text between dozens of the world's written languages.

Using these services, you will produce a website written in Python—already among the world's most popular programming languages—and the Flask framework for Python web applications. This site will translate signage in photos, which is a feature your client can build on to attract new customers and keep existing ones.

Sound like fun? Let's get started.

## Learning objectives

In this module, you build a website named Contoso Travel step by step. First, you prepare a development environment that supports applications written by using Python and Flask. Then, you learn the basics of Flask. Next, you build the website and use Azure Cognitive Services to extract and translate text. Finally, after testing the website locally, you deploy it to Azure for the whole world to enjoy. Along the way, you will:

- Learn how to set up a Flask development environment.
- Learn how to use Flask to build a page that accepts photo uploads.
- Learn how to use the Computer Vision API to extract text from photos.
- Learn how to use the Translator Text API to translate text extracted from photos.
- Learn how to deploy the application to Azure.

## Prerequisites

- Python 3.6 or later. Follow the steps in the [Install Python 3](https://docs.microsoft.com/learn/modules/python-install-vscode/3-exercise-install-python3?azure-portal=true) module. At the top of the article, choose the instructions for your configuration: Windows, Linux, or macOS.
- The Azure CLI.
- Visual Studio Code.
