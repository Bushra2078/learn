One of the first things you will find yourself doing with most datasets is computing the summary statistics for the data in order to get a general overview of your data before exploring it further. These summary statistics include the mean and standard deviation, in addition to other aggregates, such as the sum, product, median, minimum and maximum, or quantiles of the data.

NumPy has fast built-in aggregation functions for working on arrays that are the subject of this sub-section.

## Summing the values of an array

You can use the built-in Python `sum` function to sum up the values in an array.

```python
import numpy as np
```

```python
myList = np.random.random(100)
sum(myList)
```

```output
50.461758453195614
```

If you guessed that there is also a built-in NumPy function for this, you guessed correctly:

```python
np.sum(myList)
```

```output
50.46175845319564
```

And if you guessed that the NumPy version is faster, you are doubly correct:

```python
large_array = np.random.rand(1000000)
%timeit sum(large_array)
%timeit np.sum(large_array)
```

```output
124 ms ± 5.38 ms per loop (mean ± std. dev. of 7 runs, 10 loops each)
814 µs ± 74.4 µs per loop (mean ± std. dev. of 7 runs, 1000 loops each)
```

For all their similarity, bear in mind that `sum` and `np.sum` are not identical; their optional arguments have different meanings, and `np.sum` is aware of multiple array dimensions.

## Minimum and maximum

Just as Python has built-in `min` and `max` functions, NumPy has similar, vectorized versions:

```python
np.min(large_array), np.max(large_array)
```

```output
(7.071203171893359e-07, 0.9999997207656334)
```

You can also use `min`, `max`, and `sum` (and several other NumPy aggregates) as methods of the array object itself:

```python
print(large_array.min(), large_array.max(), large_array.sum())
```

```output
7.071203171893359e-07 0.9999997207656334 500216.8034810001
```

## Multidimensional aggregates

Because you will often treat the rows and columns of two-dimensional arrays differently (treating columns as variables and rows as observations of those variables, for example), it can often be desirable to aggregate array data along a row or column. Let's consider a two-dimensional array:

```python
md = np.random.random((3, 4))
print(md)
```

```output
[[0.79832448 0.44923861 0.95274259 0.03193135]
 [0.18441813 0.71417358 0.76371195 0.11957117]
 [0.37578601 0.11936151 0.37497044 0.22944653]]
```

Unless you specify otherwise, each NumPy aggregation function will compute the aggregate for the entire array. Hence:

```python
md.sum()
```

```output
5.1136763453287335
```

Aggregation functions take an additional argument specifying the *axis* along which to compute the aggregation. For example, we can find the minimum value within each column by specifying `axis=0`:

```python
md.min(axis=0)
```

```output
array([0.18441813, 0.11936151, 0.37497044, 0.03193135])
```

#### Try it yourself

What do you get when you try `md.max(axis=1)`?

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  md.max(axis=1)
  ```
  
  ```output
  array([0.95274259, 0.76371195, 0.37578601])
  ```
  
</details>

Remember that the `axis` keyword specifies the *dimension of the array that is to be collapsed*, not the dimension that will be returned. Thus specifying `axis=0` means that the first axis will be the one collapsed: for two-dimensional arrays, this means that values within each column will be aggregated.

## Other aggregation functions

The table below lists other aggregation functions in NumPy. Most NumPy aggregates have a '`NaN`-safe' version, which computes the result while ignoring missing values marked by the `NaN` value.

| Function Name | NaN-safe Version | Description |
| --- | --- | --- |
| `np.sum` | `np.nansum` | Compute sum of elements |
| `np.prod` | `np.nanprod` | Compute product of elements |
| `np.mean` | `np.nanmean` | Compute mean of elements |
| `np.std` | `np.nanstd` | Compute standard deviation |
| `np.var` | `np.nanvar` | Compute variance |
| `np.min` | `np.nanmin` | Find minimum value |
| `np.max` | `np.nanmax` | Find maximum value |
| `np.argmin` | `np.nanargmin` | Find index of minimum value |
| `np.argmax` | `np.nanargmax` | Find index of maximum value |
| `np.median` | `np.nanmedian` | Compute median of elements |
| `np.percentile` | `np.nanpercentile` | Compute rank-based statistics of elements |
| `np.any` | N/A | Evaluate whether any elements are true |
| `np.all` | N/A | Evaluate whether all elements are true |

We will see these aggregates often throughout the rest of the course.

>[!div class="alert is-tip"]
>### Takeaway
>
>Aggregation is the primary means you will use to explore you data, not just when using NumPy, but particularly in conjunction with pandas, the Python library you will learn about in the next section, which builds off of NumPy and thus off of everything you have learned thus far.
