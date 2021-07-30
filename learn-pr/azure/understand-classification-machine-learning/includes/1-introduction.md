Classification models’ outputs are categorical, meaning they can be used for labeling inputs or decision making. For example, a self-driving car uses classification to decide whether to turn left or right at a fork in the road. A classification model is different from classical regression models where outputs are continuous, such as the size of a shoe or the speed of a train. Classification models are diverse in how they work. To get started, we'll focus on logistic regression, which is a simpler and popular type of model that is used extensively across many arms of science and industry.

## Scenario: Predicting avalanches with machine learning

Throughout this module, we’ll be using the following example scenario to explain concepts related to classification. This scenario is designed to provide an example for how you might meet these concepts while programming yourself.

Your charity is responsible for avalanche-rescue operations at ski slopes and hiking trails across the north-west of the USA. While the safest option would be to permanently close all trails over the winter, that would mean no sportspeople would get to enjoy the great outdoors! Your goal is to build a model that can predict whether an individual day is likely to result in an avalanche, so that you can close the trail when the risk is high. Keep in mind as you make prediction that predicting avalanches that don't happen can hurt local tourism, while failing to predict avalanches that do happen can result in loss of life. Clearly, a balance must be found.

For those eager hikers and skiers out there: machine learning can be used for avalanche prediction, but the data for these exercises are completely fabricated and solely for educational purposes. Please don’t use this data or your trained model for anything except learning about machine learning.

## Prerequisites

* Familiarity with machine learning models

## Learning objectives

In this module, you will:

* Discover how classification differs from classical regression
* Build models that can perform classification tasks
* Explore how to assess and improve classification models
