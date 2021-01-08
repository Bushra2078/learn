We'll use the Azure Cognitive Services Custom Vision service to create a machine learning model. Let's learn more about how Custom Vision works. Then, you'll see the step-by-step process for building a model, from idea to fully functioning model!

## What is machine learning?

It's likely that you've heard of AI, machine learning, or deep learning before. Let's identify the terms and understand how they are different.

- **Artificial intelligence (AI)**: AI is the process of programming a computer to mimic human intelligence. AI includes *machine learning*. The idea of AI is as simple as trying to mimic human intelligence by using a machine, but AI includes many different techniques. The technique this module focuses on is machine learning.

- **Machine learning**: Machine learning is a subset of AI. Machine learning uses techniques to enable machines to use *experience*. Think of experience as a dataset, with right and wrong answers already given. In machine learning, the computer uses the answers that are supplied to improve how the computer completes specific tasks. The field of machine learning also includes *deep learning*.

- **Deep learning**: Deep learning is a subset of machine learning that's based on *artificial neural networks* (ANNs). The learning process is *deep* because the structure of ANNs consists of multiple layers: input, output, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a certain predictive task. The neural network structure enables a machine to learn through its own data processing.

   :::image type="content" source="../media/machine-learning-process.png" alt-text="A graphical depiction of the relationship between A I, machine learning, and deep learning." border="false":::

When we build a model, we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.

## What is transfer learning?

Azure Cognitive Services Custom Vision uses *transfer learning*. Transfer learning is the ability to use prior knowledge to better solve the current problem. As humans, we take this approach to problem solving all the time. We are discovering new ways to do it with computers, too. 

The way transfer learning works with the Custom Vision service in Azure is to add a layer in the neural network that's a pretrained model. The trained model gives us a head start when we train new data. It starts with a general-knowledge domain, and then new layers are added to the neural network to solve a specific problem. In this case, the problem we want to solve is how to identify birds. By starting with a pretrained model, we can get better results with adding less data.

## The model building process

To better understand the model building process, here's a step-by-step overview of the process and how we'll complete the process to create a model:

1. *Ask a pointed question.* Our question is, can we identify a bird's species from an image of a bird, to help document different trends and patterns of bird habits?

1. *Prepare data.* We have a dataset of bird images from the CLO that's clean and prepared, so this step is taken care of for us. If you built a different model, you would need to find and prepare data for training the model. You would want to find data that would help you answer the pointed question (step 1) that you're interested in.

1. *Select an algorithm.* The Custom Vision service in Azure uses a *convolutional neural network (CNN)*, so we don't have to worry about this step. A CNN is a type of deep learning that's commonly used to analyze images. Having the algorithm already created saves us a *lot* of time!

1. *Select a candidate model.* The Custom Vision service gives us helpful graphs and data to help us determine whether our model is performing well enough to satisfactorily answer our question. When we think the model is performing well enough, we move to the next step: test.

1. *Test the model by using unseen (new) data.* It's important to test our model by adding new data. We'll do an internet search and find some test images to see how it performs with data it wasn't trained with. We'll discuss later in the module why testing this way is important.

1. *Deploy the model.* Custom Vision gives us some options here. We can deploy to an endpoint to integrate the model, or we can download the model. If you download the model, you can choose from multiple formats to deploy the way that works best for your project. In this module, we'll discuss how to use the quick-deploy option.

Let's get started building our model!
