Our goal was to use several different techniques to change the data type of a given value.  

We used *implicit conversion*, relying on the C# compiler to perform *widening conversions*. When the compiler was unable to perform an implicit conversion, we used *explicit conversions*.  We used the `ToString()` method to explicitly convert a numeric data type into a `string`.

When we needed to perform `narrowing conversions`, we used several different techniques.  We used the casting operator `()` when the conversion could be made safely and were willing to accept truncation of values after the decimal.  And we used the `Convert()` method when we wanted to perform a conversion and use common rounding rules when performing a narrowing conversion.
 
Finally, we used the `TryParse()` methods when the conversion from a `string` to a numeric data type could potentially result in a data type conversion exception.

Without this wealth of options, it would be difficult to work in a strongly typed programming language.  Fortunately, this well executed system of types, conversion, and casting can be harnessed to build error free applications.

## Learn more with a Channel 9 video series

- [C# 101](https://channel9.msdn.com/Series/CSharp-101/?WT.mc_id=Educationalcsharp-c9-scottha&azure-portal=true)
- [C# Advanced](https://channel9.msdn.com/Series/C-Advanced/?&WT.mc_id=EducationalAdvancedCsharp-c9-niner&azure-portal=true)
