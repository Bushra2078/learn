There are multiple algorithms you can use for clustering. Perhaps the two best-known clustering approaches are: *K-means clustering* and *hierarchical clustering*.

## Train a K-Means clustering model 

The algorithm we previously used to approximate the number of clusters in our data set is called *K-Means*. Let’s get to the finer details, shall we? 

The basic algorithm has the following steps: 

1. Specify the number of clusters to be created (this is done by the data scientist). Taking the flowers example we used at the beginning of the lesson, this means deciding how many clusters you want to use to group the flowers. 
1. Next, the algorithm randomly selects *K* observations from the data set to serve as the initial centers for the clusters (that is, *centroids*). 
1. Each of the remaining observations (in this case flowers) are assigned to its closest centroid. 
1. The new means of each cluster is computed and the centroid is moved to the mean. 
1. Now that the centers have been recalculated, every observation is checked again to see if it might be closer to a different cluster. All the objects are reassigned again using the updated cluster means. The cluster assignment and centroid update steps are iteratively repeated until the cluster assignments stop changing (that is, when *convergence* is achieved). Typically, the algorithm terminates when each new iteration results in negligible movement of centroids and the clusters become static. 
1. Note that due to randomization of the initial *K* observations used as the starting centroids, we can get slightly different results each time we apply the procedure. For this reason, most algorithms use several *random starts* and choose the iteration with the lowest *within cluster sum of squares* (WCSS). As such, it's strongly recommended to always run *K-Means* with several values of *nstart* to avoid an *undesirable local optimum*. 

So, training usually involves multiple iterations, reinitializing the centroids each time, and the model with the best (lowest) WCSS is selected. The following animation shows this process: 

:::image type="content" source="../media/k-means.gif" alt-text="Animation showing a collection of flowers with different numbers of petals and leaves." border="false":::

## Hierarchical clustering 

The first step in *K-Means clustering* is the data scientist specifying the number of clusters *K* to partition the observations into. Hierarchical clustering is an alternative approach which doesn't require the number of clusters to be defined in advance. 

In hierarchical clustering, the clusters themselves belong to a larger group, which belong to even larger groups, and so on. The result is that data points can be clusters in differing degrees of precision: with a large number of very small and precise groups, or a small number of larger groups. 

For example, if we apply clustering to the meanings of words, we may get a group containing adjectives specific to emotions ('angry', 'happy', and so on), which itself belongs to a group containing all human-related adjectives ('happy', 'handsome', 'young'), and this belongs to an even higher group containing all adjectives ('happy', 'green', 'handsome', 'hard' etc.). 

:::image type="content" source="../media/hierarchical-clustering.png" alt-text="Diagram showing hierarchical clustering." border="false":::

Hierarchical clustering is useful for not only breaking data into groups, but understanding the relationships between these groups. A major advantage of hierarchical clustering is that it doesn't require the number of clusters to be defined in advance, and can sometimes provide more interpretable results than non-hierarchical approaches. The major drawback is that these approaches can take much longer to compute than simpler approaches and sometimes are not suitable for large datasets. 