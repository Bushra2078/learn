<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

> [!Note]
> **Sarah: Conversion feedback**
> 
> - Should we show the plot output message blocks that are shaded pink?
>    If so, how should these blocks be formatted -- as code blocks?
>
> - Suggest moving the **Takeaway** at the end of the unit, to the list of Learning objectives
>    in the Introduction unit or to the abstract summary in the module index.yml.
>

> [!Note]
> **Sarah: Action items**
> 
> - Try it yourself block needs Input and Output code. Search on TBD.
>

Now, a moment of truth: let's see how our model does making predictions based on the test data:

```python
predictions = reg.predict(X_test)

predictions
```

Our predictions are just an array of numbers:

```Output
array([ 614607.96220733, 1849444.80372637, 1118945.0888425 , ...,
        834789.0342857 , 1787928.10906922, 1455422.23696486])
```

These are the house prices predicted by our model. One for every row in our test dataset.

Remember how we mentioned that linear models have the mathematical form of $Y = B_0 + B_1 \times X + E$? Let’s look at the actual equation:

```python
print(reg.intercept_,reg.coef_)
```

The output is:

```Output
-2646401.726324682 [2.15873958e+01 1.65828187e+05 1.21323502e+05 2.79025671e+03
 1.51667244e+01]
```

In algebraic terms, here is our model:

$Y=-2,646,401+0.21587X_1+0.00002X_2+0.00001X_3+0.00279X_4+0.00002X_5$

Where:

- $Y=$ Price
- $X_1=$ Average area income
- $X_2=$ Average area house age
- $X_3=$ Average area number of rooms
- $X_4=$ Average area number of bedrooms
- $X_5=$ Area population

So, just how good is our model? There are many ways to measure the accuracy of ML models. Linear models have a good one: the $R^2$ score (also knows as the coefficient of determination). A high $R^2$, close to 1, indicates better prediction with less error.

```python
#Explained variation. A high R2 close to 1 indicates better prediction with less error.
from sklearn.metrics import r2_score

r2_score(y_test,predictions)
```

The output is:

```Output
0.921660486570713
```

The $R^2$ score also indicates how much explanatory power a linear model has. In the case of our model, the five predictors we used in the model explain a little more than 92 percent of the price of a house in this dataset.

We can also plot our errors to get a visual sense of how wrong our predictions were:

```python
#plot errors
sns.distplot([y_test-predictions])
```

If the `disttplot` command produces a deprecation warning, you can disregard the message:

```Output
/home/nbuser/anaconda3_420/lib/python3.5/site-packages/scipy/stats/stats.py:1713: FutureWarning: Using a non-tuple sequence for multidimensional indexing is deprecated; use `arr[tuple(seq)]` instead of `arr[seq]`. In the future this will be interpreted as an array index, `arr[np.array(seq)]`, which will result either in an error or a different result.
  return np.add.reduce(sorted[indexer] * weights, axis=axis) / sumval
```

Here is the plot graph output:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x1aeb567edc8>
```

:::image type="content" alt-text="A bell-shaped curve graph showing the dist plot output for the prediction." source="../media/output-dist-plot-2.png" loc-scope="azure":::

Do you notice the numbers on the left axis? Whereas a histogram shows the number of things that fall into discrete numeric buckets, a kernel density estimation (KDE, and the histogram that accompanies it in the Seaborn displot) normalizes those numbers to show what proportion of results lands in each bucket. Essentially, these are all decimal numbers less than 1.0 because the area under the KDE has to add up to 1.

Maybe more gratifying, we can plot the predictions from our model:

```python
# Plot outputs
plt.scatter(y_test,predictions, color='blue')
```

```Output
<matplotlib.collections.PathCollection at 0x1aeb56e32c8>
```

:::image type="content" alt-text="A scatter graph showing the dist plot output for the prediction." source="../media/output-scatter-plot-1.png" loc-scope="azure":::

The linear nature of our predicted prices is clear enough, but there are so many of them that it is hard to tell where dots are concentrated. Can you think of a way to refine this visualization to make it clearer, particularly if you were explaining the results to someone?

### Try it yourself

<br />

<details> 

  <summary>Remember to try the <i>plt.scatter</i> parameter <i>alpha=</i>. It takes values between 0 and 1. <i>(expand to reveal)</i></summary>

  Here's the input:

  ```python
  TBD
  ```

  The output is:

  ```Output
  TBD
  ```
  
</details>

<br /><br />

***

> [!div class="alert is-tip"]
> ### Takeaway
>
> In this unit, you performed prediction using linear regression by exploring your data, then fitting your model, and finally evaluating your model’s performance.
