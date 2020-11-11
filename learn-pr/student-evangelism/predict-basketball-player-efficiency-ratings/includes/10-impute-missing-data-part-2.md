As confirmed by `player_df.isna().sum()` in the previous unit, we only have nine missing values remaining in `PER`. Because we can't use a simple average to impute values in that column, a little domain expertise can help.

PER is computed from the values of the nine columns before it in the DataFrame (`GP` through `REBR`). However, it is also a very complicated statistic to compute (details at [basketball-reference.com](https://www.basketball-reference.com/about/per.html?azure-portal=true)). So, we're going to do what data scientists do: build a model to give us a good approximation!

We would like to build a simple linear regression model to estimate the missing `PER` values. However, as with any estimate, we have to ask ourselves how accurate it is.

To get some sense of how accurate a model might be, it is common in machine learning to split ones data into two subsets: test and training. The training subset would be a portion of the data the is used to train the model, and the other subset would be used to test the model. A common split is to use 75% of the data to train the model and 25% of the data to test the model. However, what if we get unusually lucky or unlucky with our random split of test and training data? For example, what if you chose all human players to train the model, but then tested the accuracy of the model on the Looney Tunes players? It is unlikely to yield accurate results.

To avoid this, statisticians and data scientists use a technique call cross validation. The idea is to iterate through the dataset splitting the data in different ways between training and test data. Doing this multiple times should give us a reasonable idea of how the model will work with new data, even if we only have limited data to work with. This graphic provides a visualization of the cross-validation process:

![K-fold cross validation](../media/k-fold-cross-validation.png)

## Cross-validate the r2 scores for the model

We will us a 10-fold cross validation, meaning that Python will iterate through the data 10 times reserving 10% of the data for testing and training on the other 90% each time. We'll also plot a histogram of the results.

One note on reading the Python code. We define the our predictors as the `X` by longstanding convention; for purposes of building our model, we want to use only rows that contain now `NaN` values (`player_df.dropna(how='any')`), then use the `iloc` DataFrame attribute to select columns to use by number rather than name (`iloc[:, 4:-1]`), and finally we want to use only the values from the resulting DataFrame slice rather than the slice in DataFrame form (with the `to_numpy()` method being preferred over the DataFrame `values` attribute per the `pandas.DataFrame.values` [documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.values.html?azure-portal=true)). The code of the predicted value (`y`) is similar to that for `X` except that we don't have to scrape out just the values.

```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score
from sklearn.model_selection import cross_val_score

# Define the variables for the regression model as those rows with no missing values.
X = player_df.dropna(how='any').iloc[:, 5:-1].to_numpy()
y = player_df.dropna(how='any').iloc[:, -1]

# Define the regression model.
lin_reg = LinearRegression()

# Use the scikit-learn cross-validation function to fit this model ten times and return the r2 scores.
scores = cross_val_score(lin_reg, X, y, cv=10, scoring='r2')

# Define the histogram of the scores and copy out information from the histogram.
entries, bin_edges, patches = plt.hist(scores, bins=10);

# Print out the mean and the results from the histogram.
print('Mean r2 score: {:.4f}'.format(scores.mean()))
for i in range(len(entries)):
    if entries[i] > 0:
        print('{:.0f}% of r2 scores are between {:.4f} and {:.4f}'.format(entries[i]*100/len(entries), 
        bin_edges[i], 
        bin_edges[i+1]))
```

```output
Mean r2 score: 0.9993
10% of r2 scores are between 0.9962 and 0.9966
10% of r2 scores are between 0.9985 and 0.9989
10% of r2 scores are between 0.9992 and 0.9996
70% of r2 scores are between 0.9996 and 1.0000
```

![Histogram of r2 scores](../media/cross-validation.png)

>[!NOTE]
>If you get an error when running this code, make sure you've installed the [scitkit-learn library, instructions here](https://scikit-learn.org/stable/install.html?azure-portal=true).

In short, our model is good. The $R^2$ score (ours is 99.93%) tells us how much variance in the data our model captures, and for our purposes this will serve as a loose proxy for our model's accuracy. Our lowest $R^2$ scores are still quite good, and most of them bump up close to the maximum value of 1, so we should feel quite confident applying this to our missing `PER` values.

>[!NOTE]
>Your exact r2 scores might be slightly different. Since each time we run this model we are going to get a different random sampling of data per cut across the 10 cuts, the model may be slightly better or slightly worse between runs. Your numbers should be fairly close to these, however.

## Fit the regression model for the player data

Now we fit the regression model to all of our data. (The general rule of thumb is that you use cross validation for model selection or evaluation, but you use all of your data for model building.)

```python
# Fit the same regression model, this time using all of the available data.
lin_reg.fit(X, y)
```

```output
LinearRegression(copy_X=True, fit_intercept=True, n_jobs=None, normalize=False)
```

## Create a mask of rows with missing values in the DataFrame

There isn't an elegant way to use `fillna()` to use the results from our model to fill in the missing `PER` values, so we have to use a *mask*.

A mask in pandas is a Boolean map of values that fulfill a certain condition or set of conditions. In order to fill in just our remaining values, we want a mask that looks like this:

```python
# Create and display a mask of rows in the DataFrame with at least one NaN value in them.
mask = player_df.isnull().any(axis=1)
mask
```

```output
0     False
1     False
2      True
3     False
4     False
5     False
6     False
7      True
8      True
9     False
10    False
11     True
12    False
13    False
14    False
15     True
16    False
17    False
18    False
19    False
20     True
21    False
22    False
23    False
24     True
25    False
26    False
27    False
28    False
29     True
30    False
31    False
32    False
33    False
34    False
36    False
37    False
38     True
39    False
40    False
41    False
42    False
dtype: bool
```

Applying that mask to just the columns that we used as X in our model using the loc DataFrame method, we get this:

```python
# Apply the mask defined above to show the contents of specific columns of rows containing NaN values.
player_df.loc[mask].iloc[:, 5:-1]
```

**Output**

| | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR |
|---|---|---|---|---|---|---|---|---|
| 2 | 55.000000 | 36.300000 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 |
| 7 | 57.000000 | 35.272973 | 0.574 | 24.4 | 11.3 | 26.3 | 5.5 | 5.8 | -2.2 |
| 8 | 61.000000 | 35.600000 | 0.547 | 22.9 | 12.2 | 22.7 | 5.8 | 6.4 | -2.9 |
| 11 | 59.972222 | 31.700000 | 0.584 | 32.4 | 14.7 | 16.5 | 3.2 | 19.0 | 4.1 |
| 15 | 59.972222 | 34.900000 | 0.603 | 26.2 | 11.1 | 36.7 | 3.0 | 14.3 | 5.3 |
| 20 | 61.000000 | 35.272973 | 0.645 | 20.6 | 13.1 | 31.5 | 4.0 | 12.0 | 5.2 |
| 24 | 48.000000 | 35.100000 | 0.569 | 19.0 | 10.9 | 29.2 | 4.6 | 17.7 | 5.2 |
| 29 | 64.000000 | 36.300000 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 |
| 38 | 64.000000 | 36.500000 | 0.618 | 31.3 | 14.0 | 34.9 | 5.9 | 21.3 | 14.5 |

Now we have identified hte 9 rows that have a `NaN` value in the `PER` column, and have the columns that can be used in the machine learning model to predict the PER value.

## Use the mask and the fitted mask to impute the final missing values in the DataFrame

A mask is particularly useful for us here because it lets us use a *view* of the `player_df` DataFrame rather than a `slice` of it. When we defined `X`, we used `player_df.dropna(how='any').iloc[:, 5:-1].to_numpy()`. The `dropna()` method creates a new DataFrame object by default when it is called (which is why we used the method's `inplace` parameter to use is on the original DataFrame). Thus any changes to values that we might make in the `X` DataFrame would not change values in the `player_df` DataFrame.

Our mask is different. If simply enables us to work with a subset of the `player_df` DataFrame. This means that any changes we make to the DataFrame while applying the mask will also apply to the `player_df` DataFrame as a whole. 

```python
# Impute the missing values in 'PER' using the regression model and mask
player_df.loc[mask, 'PER'] = lin_reg.predict(player_df.loc[mask].iloc[:, 5:-1])

# Recheck the DataFrame for rows with missing values.
player_df.isna().sum()
```

```output
ID             0
player         0
points         0
possessions    0
team_pace      0
GP             0
MPG            0
TS%            0
AST            0
TO             0
USG            0
ORR            0
DRR            0
REBR           0
PER            0
dtype: int64
```

Finally, let's review the entire DataFrame to see is not without any missing values.

```python
# Display entire DataFrame.
player_df
```

**Output**

| | ID | player | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | player1 | 1893.0 | 1251.8 | 97.8 | 63.000000 | 33.900000 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.900000 |
| 1 | 2 | player2 | 1386.0 | 1282.5 | 110.5 | 58.000000 | 32.500000 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.300000 |
| 2 | 3 | player3 | 1405.0 | 1252.3 | 105.8 | 55.000000 | 36.300000 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | 16.585893 |
| 3 | 4 | player4 | 1282.0 | 1235.9 | 100.7 | 54.000000 | 37.600000 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.350000 |
| 4 | 5 | player5 | 1721.0 | 1254.0 | 105.7 | 59.000000 | 30.500000 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.380000 |
| 5 | 6 | player6 | 1004.0 | 1322.4 | 102.1 | 57.000000 | 36.300000 | 0.574 | 20.3 | 13.5 | 31.0 | 1.2 | 20.5 | 3.4 | 9.830000 |
| 6 | 7 | player7 | 1920.0 | 1207.6 | 109.8 | 55.000000 | 37.000000 | 0.573 | 26.0 | 13.1 | 30.7 | 0.0 | 10.3 | -2.6 | 8.710000 |
| 7 | 8 | player8 | 1353.0 | 1348.1 | 112.2 | 57.000000 | 35.272973 | 0.574 | 24.4 | 11.3 | 26.3 | 5.5 | 5.8 | -2.2 | 8.708429 |
| 8 | 10 | player10 | 1468.0 | 1400.9 | 93.7 | 61.000000 | 35.600000 | 0.547 | 22.9 | 12.2 | 22.7 | 5.8 | 6.4 | -2.9 | 3.104597 |
| 9 | 11 | player11 | 1856.0 | 1303.8 | 93.4 | 55.000000 | 33.600000 | 0.563 | 28.9 | 14.7 | 26.7 | 1.4 | 17.3 | 4.3 | 9.670000 |
| 10 | 12 | player12 | 1058.0 | 1231.5 | 99.4 | 63.000000 | 32.800000 | 0.550 | 25.1 | 12.9 | 27.2 | 2.1 | 12.1 | 11.4 | 22.97000 |
| 11 | 13 | player13 | 1452.0 | 1246.1 | 103.6 | 59.972222 | 31.700000 | 0.584 | 32.4 | 14.7 | 16.5 | 3.2 | 19.0 | 4.1 | 3.387587 |
| 12 | 14 | player14 | 1438.0 | 1499.6 | 108.1 | 60.000000 | 35.000000 | 0.569 | 28.6 | 12.2 | 36.2 | 4.9 | 6.0 | 7.4 | 27.570000 |
| 13 | 15 | player15 | 1782.0 | 1329.0 | 104.6 | 51.000000 | 35.272973 | 0.590 | 26.5 | 9.9 | 29.7 | 3.1 | 29.4 | 5.5 | 9.380000 |
| 14 | 16 | player16 | 1276.0 | 1257.5 | 89.7 | 58.000000 | 32.800000 | 0.572 | 15.5 | 16.2 | 23.8 | 3.4 | 15.4 | 6.0 | 9.490000 |
| 15 | 17 | player17 | 1486.0 | 1343.6 | 100.6 | 59.972222 | 34.900000 | 0.603 | 26.2 | 11.1 | 36.7 | 3.0 | 14.3 | 5.3 | 22.612442 |
| 16 | 18 | player18 | 1326.0 | 1542.0 | 107.8 | 52.000000 | 31.800000 | 0.583 | 25.3 | 11.7 | 30.6 | 3.3 | 9.9 | 5.3 | 19.780000 |
| 17 | 19 | player19 | 1535.0 | 1336.2 | 104.0 | 56.000000 | 35.400000 | 0.636 | 27.2 | 10.8 | 29.9 | 0.7 | 5.6 | 7.9 | 30.440000 |
| 18 | 21 | player21 | 1276.0 | 1354.9 | 101.2 | 50.000000 | 35.272973 | 0.560 | 21.4 | 12.4 | 28.6 | 2.6 | 9.3 | 10.3 | 24.230000 |
| 19 | 22 | player22 | 1784.0 | 1287.1 | 101.3 | 59.000000 | 33.800000 | 0.601 | 27.2 | 12.4 | 21.8 | 2.9 | 5.2 | 9.9 | 25.150000 |
| 20 | 23 | player23 | 1729.0 | 1205.0 | 103.8 | 61.000000 | 35.272973 | 0.645 | 20.6 | 13.1 | 31.5 | 4.0 | 12.0 | 5.2 | 21.262780 |
| 21 | 24 | player24 | 1639.0 | 1287.4 | 105.2 | 52.000000 | 35.400000 | 0.570 | 32.7 | 15.0 | 26.6 | 1.6 | 5.0 | 9.4 | 25.120000 |
| 22 | 26 | player26 | 1370.0 | 1384.7 | 103.3 | 59.972222 | 34.200000 | 0.571 | 14.8 | 9.9 | 33.1 | 2.4 | 16.3 | 3.7 | 15.040000 |
| 23 | 27 | player27 | 1497.0 | 1410.9 | 98.3 | 57.000000 | 34.100000 | 0.613 | 15.4 | 10.0 | 29.3 | 3.8 | 5.7 | 6.7 | 25.350000 |
| 24 | 28 | player28 | 1313.0 | 1420.5 | 105.0 | 48.000000 | 35.100000 | 0.569 | 19.0 | 10.9 | 29.2 | 4.6 | 17.7 | 5.2 | 12.920786 |
| 25 | 29 | player29 | 1464.0 | 1353.4 | 103.3 | 63.000000 | 34.400000 | 0.595 | 17.9 | 9.2 | 29.3 | 1.0 | 8.7 | 4.1 | 20.490000 |
| 26 | 31 | looney_tune1 | 2049.0 | 1434.0 | 110.0 | 64.000000 | 38.800000 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.440000 |
| 27 | 32 | looney_tune2 | 1795.0 | 1481.8 | 112.1 | 62.000000 | 35.400000 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.340000 |
| 28 | 33 | looney_tune3 | 1805.0 | 1509.9 | 108.6 | 64.000000 | 35.400000 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.410000 |
| 29 | 34 | looney_tune4 | 1743.0 | 1422.4 | 112.9 | 64.000000 | 36.300000 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | 29.858714 |
| 30 | 35 | looney_tune5 | 1963.0 | 1539.1 | 117.4 | 59.972222 | 35.272973 | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.160000 |
| 31 | 36 | looney_tune6 | 2062.0 | 1505.7 | 111.5 | 59.972222 | 37.000000 | 0.620 | 29.8 | 15.6 | 36.2 | 4.9 | 23.9 | 14.7 | 27.860000 |
| 32 | 37 | looney_tune7 | 1845.0 | 1435.7 | 113.1 | 69.000000 | 36.900000 | 0.634 | 33.2 | 14.0 | 36.5 | 4.1 | 21.5 | 16.4 | 34.260000 |
| 33 | 38 | looney_tune8 | 1778.0 | 1526.4 | 109.3 | 66.000000 | 34.900000 | 0.612 | 30.6 | 15.9 | 35.9 | 5.5 | 18.8 | 13.7 | 28.650000 |
| 34 | 39 | looney_tune9 | 1901.0 | 1444.1 | 109.7 | 67.000000 | 36.500000 | 0.609 | 27.2 | 14.8 | 35.5 | 5.0 | 21.8 | 8.9 | 20.120000 |
| 35 | 41 | looney_tune11 | 2030.0 | 1431.0 | 112.3 | 68.000000 | 37.000000 | 0.618 | 32.5 | 15.3 | 34.5 | 5.7 | 15.7 | 13.2 | 30.070000 |
| 36 | 42 | looney_tune12 | 1631.0 | 1465.7 | 110.1 | 66.000000 | 37.500000 | 0.613 | 28.4 | 14.4 | 35.7 | 6.5 | 20.7 | 14.0 | 28.400000 |
| 37 | 43 | looney_tune13 | 1828.0 | 1507.2 | 112.7 | 64.000000 | 36.500000 | 0.618 | 31.3 | 14.0 | 34.9 | 5.9 | 21.3 | 14.5 | 29.102157 |
| 38 | 44 | looney_tune14 | 1821.0 | 1443.7 | 118.8 | 66.000000 | 36.600000 | 0.609 | 27.3 | 13.5 | 35.8 | 7.0 | 23.8 | 11.5 | 22.960000 |
| 39 | 45 | looney_tune15 | 1604.0 | 1526.5 | 114.5 | 67.000000 | 37.600000 | 0.633 | 28.2 | 13.0 | 34.2 | 6.1 | 19.0 | 16.3 | 33.890000 |
| 40 | 46 | looney_tune16 | 1740.0 | 1443.9 | 114.1 | 68.000000 | 37.100000 | 0.611 | 26.6 | 15.2 | 29.3 | 8.3 | 17.7 | 11.1 | 21.220000 |
| 41 | 47 | looney_tune17 | 1993.0 | 1459.0 | 112.5 | 59.972222 | 36.900000 | 0.627 | 30.4 | 15.0 | 33.7 | 6.3 | 19.3 | 14.1 | 28.760000 |

Finally, we can save this final DataFrame to a CSV file so that we can use this dataset to make pre- and in-game decisions beased on what players we have on our teams, what players are playing in the game, and what the stats of the game currently are.

```python
player_df.to_csv('player_data_final.csv', index=False)
```

>[!NOTE]
>The `index=False` parameter ensures that the index that was added to the DataFrame when pandas initially read in the CSV file doesn't get written to the CSV file.

You should now see a new CSV file in your space-jam folder.

![Final cleansed dataset ready for use](../media/output-csv.png)
