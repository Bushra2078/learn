Custom text classification projects are your workspace to build, train, improve, and deploy your classification model. You can work with your project in two ways: through *Language Studio* and via the REST API. Language Studio is the GUI that will be used in the lab, but the REST API has the same functionality. Regardless of which method you prefer, the steps for developing your model are the same.

## Language service project life cycle

![Conceptual diagram showing a life cycle with steps to define labels, tag data, train model, view model, improve model, deploy model, and classify text](../media/classify-development-lifecycle.png)

1. **Define labels**: Understanding the data you want to classify, identify the possible labels you want to categorize into. In our video game example, our labels would be "Action", "Adventure", "Strategy", and so on.
2. **Tag data**: Tag your existing data, specifying the label or labels each file falls under. Tagging data is important since it's how your model will learn how to classify future files. Best practice is to have clear differences between labels to avoid ambiguity, and provide good examples of each label for the model to learn from. For example, we'd tag "Quest for the Mine Brush" would be tagged as "Adventure", and "Flight Trainer" as "Action".
3. **Train model**: Once your data is tagged, train it with the labeled data. Training will teach our model what types of video game summaries should be labeled which genre.
4. **View model**: After your model is trained, view the results of the model. Your model is scored between 0 and 1, based on the precision and recall of the data tested. Take note of which genre didn't perform well.
5. **Improve model**: Improve your model by seeing which classifications failed to evaluate to the right label, see your label distribution, and find out what data to add to improve performance. For example, you might find your model mixes up "Adventure" and "Strategy" games. Try to find more examples of each label to add to your dataset for retraining your model.
6. **Deploy model**: Once your model performs as desired, deploy your model to make it available via the API. Your model might be named "GameGenres", and once deployed can be used to classify game summaries.
7. **Classify text**: Use your model for classifying text. The lab covers how to use the API, and you can view the [API reference](https://aka.ms/ct-runtime-swagger)

## How to split datasets for training

When tagging your data, you can specify which dataset you want each file to be:

- **Training** - The training dataset is used to actually train the model; the data and tags provided are fed into the machine learning algorithm to teach your model what data should be classified to which label. The training dataset will be the larger of the two datasets, recommended to be about 80% of your tagged data.
- **Testing** - The testing dataset is tagged data used to verify you model after it's trained. Azure will take the data in the testing dataset, submit it to the model, and compare the output to how you tagged your data to determine how well the model performed. The result of that comparison is how your model gets scored and helps you know how to improve your predictive performance.

During the **Train model** step, there are two options for how to train your model.

- **Automatic split** - Azure takes all of your data, splits it into the specified percentages randomly, and applies them in training the model. This option is best when you have a larger dataset, data is naturally more consistent, or the distribution of your data extensively covers your classes.
- **Manual split** - Manually specify which files should be in each dataset. When you submit the training job, the Language service will tell you the split of the dataset and the distribution. This split is best used with smaller datasets to ensure the correct distribution of classes and variation in data are present to correctly train your model.

To use the automatic split, put all files into the *training* dataset when tagging your data (this option is the default). To use the manual split, specify which files should be in testing versus training during the tagging of your data.

## Deployment options

The Language service allows each project to create both multiple models and multiple deployments, each with their own unique name. Benefits include ability to:

- Test two models side by side
- Compare how the split of datasets impact performance
- Deploy multiple versions of your model

> [!NOTE]
> Each project has a limit of ten deployment names

During deployment you can choose the name for the deployed model, which can then be selected when submitting a classification task:

```json
<...>
    "customClassificationTasks":[
        {
            "parameters": {
                    "project-name": "<YOUR PROJECT>",
                    "deployment-name": "<YOUR DEPLOYMENT>"
            }
        }
    ]
<...>
```

## Using the REST API

The REST API available for the Language service allows for CLI development of Language service projects in the same way that Language Studio provides a user interface for building projects. Language Studio is explored further in this module's lab.

### Pattern of using the API

The API for the Language service operates asynchronously for most calls. This means in each step we submit a request to the service first, then check back with the service via a subsequent call to get the status or result.

With each request, a header is required to authenticate your request:

|Key|Value|
|--|--|
|`Ocp-Apim-Subscription-Key`| The key to your Language resource |

#### Submit initial request

Which URL to submit the request to varies on which step you are on, but all are prefixed with the endpoint provided by your Language resource in your Azure subscription.

For example, to train a model, you would create a **POST** to the URL that would look something like the following:

```rest
<YOUR-ENDPOINT>/language/analyze-text/projects/<PROJECT-NAME>/:train?api-version=2021-11-01-preview
```

|Placeholder  |Value  | Example |
|---------|---------|---------|
|`<YOUR-ENDPOINT>`     | The endpoint for your API request  | `https://<your-custom-resource>.cognitiveservices.azure.com` |
|`<PROJECT-NAME>`     | The name for your project (value is case-sensitive)  | `myProject` |

The following body would be attached to the request:

```json
{
  "modelLabel": "<YOUR-MODEL>",
  "runValidation": true,
  "evaluationOptions":
    {
        "type":"percentage",
        "testingSplitPercentage":"30",
        "trainingSplitPercentage":"70"
    }
}
```

|Key  |Value  |
|---------|---------|
|`<YOUR-MODEL>`    | Your model name.   |
|`runValidation`     | Boolean value to run validation on the test set.  |
|`evaluationOptions`     | Specifies evaluation options.   |
|`type`     | Specifies data split type. Can be `percentage` if you're using an automatic split, or `set` if you manually split your dataset  |
|`testingSplitPercentage`     | Required integer field only if `type` is *percentage*. Specifies testing split.   |
|`trainingSplitPercentage`     | Required integer field only if `type`  is *percentage*. Specifies training split.   |

The response to the above request will be a `202`, meaning the request was successful. In the response headers grab the `location` value, which will look similar to the following URL:

```rest
<YOUR-ENDPOINT>/language/analyze-text/projects/<PROJECT-NAME>/train/jobs/<JOB-ID>?api-version=2021-11-01-preview
```

|Key|Value|
|--|--|
|`<JOB-ID>`| Identifier for your request |

This URL is used in the next step to get the training status.

#### Get training status

To get the training status, use the URL from the header of the request response to submit a **GET** request, with same header that provides our Language service key for authentication. The response body will be similar to the following JSON:

```json
{
  "jobs": [
    {
      "result": {
        "trainedModelLabel": "<YOUR-MODEL>",
        "trainStatus": {
          "percentComplete": 0,
          "elapsedTime": "string"
        },
        "evaluationStatus": {
          "percentComplete": 0,
          "elapsedTime": "string"
        }
      },
      "jobId": "string",
      "createdDateTime": "string",
      "lastUpdatedDateTime": "string",
      "expirationDateTime": "string",
      "status": "unknown",
      "errors": [
        {
          "code": "unknown",
          "message": "string"
        }
      ]
    }
  ],
  "nextLink": "string"
}
```

Training a model can take some time, so periodically check back at this status URL until the response `status` returns `succeeded`. Once the training has succeeded, you can view, verify, and deploy your model.

### Consuming a deployed model

Using the model to classify text follows the same pattern as outlined above, with a POST request submitting the job and a GET request to retrieve the results.

#### Submit text for classification

To use your model, submit a **POST** to the *analyze* endpoint at the following URL:

```rest
{YOUR-ENDPOINT}/text/analytics/v3.2-preview.2/analyze
```

|Placeholder  |Value  | Example |
|---------|---------|---------|
|`<YOUR-ENDPOINT>`     | The endpoint for your API request  | `https://<your-custom-resource>.cognitiveservices.azure.com` |

> [!IMPORTANT]
> Remember to include your resource key in the header for `Ocp-Apim-Subscription-Key`

The following JSON structure would be attached to the request:

```json
{
    "displayName": "myJob",
    "analysisInput": {
        "documents": [
            {
                "id": "doc1", 
                "text": "Text for document 1"
            },
            {
                "id": "doc2",
                "text": "Text for document 2"
            }
        ]
    },
    "displayName": "myClassification",
    "tasks": {
        "<TASK-REQUIRED>": [      
            {
                "parameters": {
                      "project-name": "<YOUR-PROJECT>",
                      "deployment-name": "<YOUR-DEPLOYMENT>"
                }
            }
        ]
    }
}
```

|Key  |Value  |
|---------|---------|
|`<TASK-REQUIRED>`     | Which task you're requesting. This is `customMultiClassificationTasks` for multiple label projects, or `customClassificationTasks` for single label projects  |
|`<YOUR-PROJECT>`    | Your project name.   |
|`<YOUR-DEPLOYMENT>`    | Your deployment name.   |

The response to the above request will be a `202`, meaning the request was successful. In the response headers, look for the `operation-location` value which will look something like the following URL:

```rest
{YOUR-ENDPOINT}/text/analytics/v3.2-preview.2/analyze/jobs/<jobId>
```

|Key|Value|
|--|--|
|`<YOUR-ENDPOINT>`| The endpoint for your API request  |
|`<JOB-ID>`| Identifier for your request |

This URL is used to get your task results.

#### Get classification results

Submit a **GET** request to the endpoint from the previous request, with the same header for authentication. The response body will be similar to the following JSON:

```json
{
    "jobId": "string",
    "lastUpdateDateTime": "string",
    "createdDateTime": "string",
    "expirationDateTime": "string",
    "status": "succeeded",
    "errors": [],
    "displayName": "string",
    "tasks": {
        "completed": 1,
        "failed": 0,
        "inProgress": 0,
        "total": 1,
        "customSingleClassificationTasks": [
            {
                "lastUpdateDateTime": "string",
                "state": "succeeded",
                "results": {
                    "documents": [
                        {
                            "id": "doc1",
                            "classification": {
                                "category": "Classification1",
                                "confidenceScore": 0.4
                            },
                            "warnings": []
                        },
                        {
                            "id": "doc2",
                            "classification": {
                                "category": "Classification2",
                                "confidenceScore": 0.6
                            },
                            "warnings": []
                        }
                    ],
                    "errors": [],
                    "projectName": "myProject",
                    "deploymentName": "myDeployment"
                }
            }
        ]
    }
}
```

The classification result is within the task array `results` object, for each document submitted.
