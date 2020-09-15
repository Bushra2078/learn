Quantum computing promises to enable algorithms that are much faster than their classical counterparts for certain types of problems. 
Identifying the problems for which a quantum speedup is possible and coming up with algorithms that offer it is an area of ongoing research.

One of such algorithms is Grover's search algorithm - one of the most famous algorithms in quantum computing. 
The problem it solves is often referred to as "searching a database", but it is more accurate to think of it as "search problem" or "inverting a function": given a function $f(x)$ that returns 0 or 1, find any input $x_0$ for which the function returns 1: $f(x_0) = 1$. 
This formulation seems rather mathematical at first, but it is powerful enough to express a broad class of problems. 
The core idea of Grover's algorithm also turns out to be an important building block of other, more complex quantum algorithms.

In this module, we'll introduce the necessary concepts and tools for implementing Grover's algorithm and applying it to solving a simple problem. Then we'll demonstrate the implementation in Q#.
Finally, we'll outline some practical aspects of using Grover's search for solving problems.

## Learning objectives

After completing this module, you'll be able to:

 - Build _quantum oracles_ that implement classical functions on a quantum computer.
 - Explain the roles _superposition_, _interference_, and _entanglement_ play in building quantum algorithms.
 - Write a Q# program that uses Grover's search algorithm to solve a graph coloring problem.
 - Recognize the kinds of problems for which Grover's search algorithm can offer speedup compared to classical algorithms.

## Prerequisites

- The latest version of [.NET Core](https://dotnet.microsoft.com/download?azure-portal=true)
- [Visual Studio Code](https://code.visualstudio.com/download?azure-portal=true)
- The [Quantum Development Kit](https://docs.microsoft.com/quantum/quickstarts/install-command-line?view=qsharp-preview&tabs=tabid-vscode?azure-portal=true)

You will need basic knowledge of the principles of quantum computing: superposition, interference, entanglement, and measurement.

You will also need some familiarity with Q# and the Quantum Development Kit.

