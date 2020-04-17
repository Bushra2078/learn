We started the discussion in this section by noting that data science starts by representing data as arrays of numbers.

"Wait!" you might be thinking. "Can't we just use Python lists for that?"

Depending on the data, yes, you could (and you will use lists as a part of working with data in Python). But to see what we might want to use a specialized data structure for, let's look a little more closely at lists.

## Lists in Python

Python lists can hold just one kind of object. Let's use one to create a list of just integers:

```python
myList = list(range(10))
myList
```

```output
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Remember list comprehension? We can use it to probe the data types of items in a list:

```python
[type(item) for item in myList]
```

```ouput
[int, int, int, int, int, int, int, int, int, int]
```

Of course, a really handy feature of Python lists is that they can hold heterogeneous types of data in a single list object:

```python
myList2 = [True, "2", 3.0, 4]
[type(item) for item in myList2]
```

```output
[bool, str, float, int]
```

However, this flexibility comes at a price. Each item in a list is really a separate Python object (the list is an object itself, true, but mostly it is an object that serves as a container for the memory pointers to the constituent objects). That means that each item in a list must contain its own type info, reference count, and other information. All of this information can become expensive in terms of memory and performance if we are dealing with hundreds of thousands or millions of items in a list. Moreover, for many uses in data science, our arrays just store a single type of data (such as integers or floats), which means that all of the object-related information for items in such an array would be redundant. It can be much more efficient to store data in a fixed-type array.

Enter the fixed-type, NumPy-style array.

## Fixed-type arrays in Python

At the level of implementation by the computer, the `ndarray` that is part of the NumPy package contains a single pointer to one contiguous block of data. This is efficient memory-wise and computationally. Better still, NumPy provides efficient *operations* on data stored in `ndarray` objects.

>[!NOTE]
>We will pretty much use "array," "NumPy array," and "ndarray" interchangeably throughout this section to refer to the ndarray object.

### Creating NumPy arrays method 1: using Python lists

There are multiple ways to create arrays in NumPy. Let's start by using our good old familiar Python lists. We will use the `np.array()` function to do this (remember, we imported NumPy as '`np`'):

Create an integer array:

```python
np.array([1, 4, 2, 5, 3])
```

```output
array([1, 4, 2, 5, 3])
```

Remember that, unlike Python lists, NumPy constrains arrays to contain a single type. So, if data types fed into a NumPy array do not match, NumPy will attempt to *upcast* them if possible. To see what we mean, here NumPy upcasts integers to floats:

```python
np.array([3.14, 4, 2, 3])
```

```output
array([3.14, 4.  , 2.  , 3.  ])
```

#### Try it yourself

What happens if you construct an array using a list that contains a combination of integers, floats, and strings?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  ```Python
  np.array([3.14, 'pi', 3])
  ```

  ```Output
  array(['3.14', 'pi', '3'], dtype='<U32')
  ```
</details>

If you want to explicitly set the data type of your array when you create it, you can use the `dtype` keyword:

```python
np.array([1, 2, 3, 4], dtype='float32')
```

```output
array([1., 2., 3., 4.], dtype=float32)
```

#### Try it yourself

Try this using a different `dtype`.

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  ```Python
  np.array([1.0, 2.5, 3, 4], dtype='int32')
  ```

  ```Output
  array([1, 2, 3, 4])
  ```
</details>

Remember that you can always refer to the documentation with the command `np.array`.

Most usefully for a lot of applications in data science, NumPy arrays can explicitly be multidimensional (like matrices or tensors). Here's one way of creating a multidimensional array using a list of lists.

Nested lists result in multi-dimensional arrays:

```python
np.array([range(i, i + 3) for i in [2, 4, 6]])
```

```output
array([[2, 3, 4],
       [4, 5, 6],
       [6, 7, 8]])
```

The inner lists in a list of lists are treated as rows of the two-dimensional array you created.

### Creating NumPy arrays method 2: building from scratch

In practice, it is often more efficient to create arrays from scratch using functions built into NumPy, particularly for larger arrays. Here are a few examples; these example will help introduce you to several useful NumPy functions.

Create an integer array of length 10 filled with zeros:

```python
np.zeros(10, dtype=int)
```

```output
array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
```

Create a 3 x 5 floating-point array filled with ones:

```python
np.ones((3, 5), dtype=float)
```

```output
array([[1., 1., 1., 1., 1.],
       [1., 1., 1., 1., 1.],
       [1., 1., 1., 1., 1.]])
```

Create a 3 x 5 array filled with 3.14.
The first number in the tuple gives the number of rows.
The second number in the tuple sets the number of columns.

```python
np.full((3, 5), 3.14)
```

```output
array([[3.14, 3.14, 3.14, 3.14, 3.14],
       [3.14, 3.14, 3.14, 3.14, 3.14],
       [3.14, 3.14, 3.14, 3.14, 3.14]])
```

Create an array filled with a linear sequence.
Starting at 0, ending at 20, stepping by 2 (this is similar to the built-in Python range() function):

```python
np.arange(0, 20, 2).
```

```output
array([ 0,  2,  4,  6,  8, 10, 12, 14, 16, 18])
```

Create an array of five values evenly spaced between 0 and 1:

```python
np.linspace(0, 1, 5)
```

```output
array([0.  , 0.25, 0.5 , 0.75, 1.  ])
```

Create a 3 x 3 array of uniformly distributed random values between 0 and 1:

```python
np.random.random((3, 3))
```

```output
array([[0.1293533 , 0.00963681, 0.76015197],
       [0.97076867, 0.16947551, 0.51899825],
       [0.28123745, 0.37741323, 0.01221669]])
```

Create a 3 x 3 array of normally distributed random values
with mean 0 and standard deviation 1:

```python
np.random.normal(0, 1, (3, 3))
```

```output
array([[ 0.41781774,  1.10706673, -1.84875856],
       [ 0.9436157 ,  0.36446661,  0.1319522 ],
       [-1.18743752,  0.48199796,  0.37693047]])
```

Create a 3 x 3 array of random integers in the interval [0, 10):

```python
np.random.randint(0, 10, (3, 3))
```

```output
array([[0, 3, 7],
       [8, 1, 8],
       [0, 5, 7]])
```

Create a 3 x 3 identity matrix:
```python
np.eye(3)
```

```output
array([[1., 0., 0.],
       [0., 1., 0.],
       [0., 0., 1.]])
```

Create an uninitialized array of three integers:
The values will be whatever happens to already exist at that memory location.
```python
np.empty(3)
```

```output
array([1., 1., 1.])
```

Now take a couple of minutes to go back and play with these code snippets, changing the parameters. These functions are the bread-and-butter of creating NumPy arrays and you will want to become comfortable with them.

Below is a table listing out several of the array-creation functions in NumPy.

| Function | Description |
| --- | --- |
| `array` | Converts input data (list, tuple, array, or other sequence type) to an ndarray either by inferring a dtype or explicitly specifying a dtype. Copies the input data by default. |
| `asarray` | Converts input to ndarray, but does not copy if the input is already an ndarray. |
| `arange` | Similar to the built-in `range()` function but returns an ndarray instead of a list. |
| `ones`, `ones_like` | Produces an array of all 1s with the given shape and dtype. <br /> <br /> `ones_like` takes another array and produces a ones-array of the same shape and dtype. |
| `zeros`, `zeros_like` | Similar to `ones` and `ones_like` but producing arrays of 0s instead. |
| `empty`, `empty_like` | Creates new arrays by allocating new memory, but does not populate with any values like `ones` and `zeros`. |
| `full`, `full_like` | Produces an array of the given shape and dtype with all values set to the indicated "fill value." <br /> <br /> `full_like` takes another array and produces a a filled array of the same shape and dtype. |
| `eye`, `identity` | Create a square N x N identity matrix (1s on the diagonal and 0s elsewhere) |

## NumPy data types

The standard NumPy data types are listed in the following table. Note that when constructing an array, they can be specified using a string:

`np.zeros(8, dtype='int16')`

Or they can be specified directly using the NumPy object:

`np.zeros(8, dtype=np.int16)`

| Data type | Description |
| --- | --- |
| `bool_` | Boolean (True or False) stored as a byte |
| `int_` | Default integer type (same as C `long`; normally either `int64` or `int32`) |
| `intc` | Identical to C `int` (normally `int32` or `int64`) |
| `intp` | Integer used for indexing (same as C `ssize_t`; normally either `int32` or `int64`) |
| `int8` | Byte (-128 to 127) |
| `int16` | Integer (-32768 to 32767) |
| `int32` | Integer (-2147483648 to 2147483647) |
| `int64` | Integer (-9223372036854775808 to 9223372036854775807) |
| `uint8` | Unsigned integer (0 to 255) |
| `uint16` | Unsigned integer (0 to 65535) |
| `uint32` | Unsigned integer (0 to 4294967295) |
| `uint64` | Unsigned integer (0 to 18446744073709551615) |
| `float_` | Shorthand for `float64`. |
| `float16` | Half-precision float: sign bit, 5 bits exponent, 10 bits mantissa |
| `float32` | Single-precision float: sign bit, 8 bits exponent, 23 bits mantissa |
| `float64` | Double-precision float: sign bit, 11 bits exponent, 52 bits mantissa |
| `complex_` | Shorthand for `complex128`. |
| `complex64` | Complex number, represented by two 32-bit floats |
| `complex128` | Complex number, represented by two 64-bit floats |

If these data types seem a lot like those in C, that's because NumPy is built in C.

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> NumPy arrays are a data structure similar to Python lists that provide high performance when storing and working on large amounts of homogeneous data - precisely the kind of data that you will encounter frequently in doing data science. NumPy arrays support many data types beyond those discussed in this course. With all of that said, however, don't worry about memorizing all of the NumPy `dtypes`. **It's often just necessary to care about the general kind of data you're dealing with: floating point, integer, Boolean, string, or general Python object.**
