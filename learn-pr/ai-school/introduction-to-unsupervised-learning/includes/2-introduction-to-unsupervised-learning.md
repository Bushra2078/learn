So far we have covered supervised learning algorithms - where we have labels for our examples. When a dataset doesn’t have labels, we can use unsupervised learning to find some kind of structure in the data - discovering patterns or groupings.

Supervised learning is much more common than unsupervised learning, but unsupervised learning can help us quickly get some analysis on a dataset with little effort.

![On a plot there are many unlabelled data points. Four circles are drawn over the data points, each circle labelling the data points a different colour.](../media/7.1_ClusteringAnimated.gif)

In the example above the model finds four groups in the unlabeled data - commonly referred to as clusters.

Unsupervised learning is commonly used in science and industry for cluster analysis and anomaly detection.

### Cluster analysis

Cluster analysis is a method of finding groupings, known as clusters, in datasets. As the datasets are unlabeled, cluster analysis tries to group similar examples using the examples features.

![Scatter plot titled 'Clustering', with the Y-axis labelled 'Independent variable 2' and the X-axis labelled 'Independent variable 1'. There are two distinct areas with data points, one in the top left-hand corner and one in the bottom-right hand corner. The top left-hand corner is circled, with all the data points blue, with a label 'Cluster 1'. The bottom right-hand corner data points are also circled, with the data points green, labelled 'Cluster 2'.](../media/7.1_cluster__1_.png)

In practice clustering tends to be used for social network analysis, computer clustering, scientific analysis in biology and astronomy, and customer analysis.

![Image with the title 'cluster network', with many circles all joined to circles close to them with black lines. The circles are in four colors - yellow, red, green and blue, with a different color in each corner. Each circle has a different name on it.](../media/7.1_ClusterNetwork.png)

There many types of cluster analysis, but AI practitioners tend to use k-means clustering for quick analysis. For in-depth unsupervised learning, there are many tools - you can use support vector machines (support vector clustering), neural networks, and so on. Next we’ll look at k-means clustering.

## Summary

Well done! In this section we covered:

* __Unsupervised learning__ - when we don't have labels for our data sets.
* Unsupervised learning is discovering patterns or groupings in this unlabeled data.
* __Cluster analysis__ - a popular type of unsupervised learning.
* __k-means clustering__ - a popular type of cluster analysis used by AI practitioners.

Next up we've got k-means! Stick with us - we're nearly at the end.
