Now that you have added classes and data to your rock paper scissors game, it's time to add the last part, behavior. Behavior in the form of methods. You will add methods to your classes and the end result is working game of rock, paper, scissors. 

## Implement behavior

You've been taught that to build a program in OOP style you model first and then you code. The modeling produced an output, a table that represented what objects, data, and behavior your program seems to consist of. Here's that same table again:

|Phase     | Actor             |Behavior                                 | Data                                            |
|----------|-------------------|-----------------------------------------|-------------------------------------------------|
|Input     | Participant       | chooses symbol                          | Symbol save as _choice_ on Participant(choice)  |
|Processing| GameRound         | compares choices against game rules     | _Result_ inspected                              |
|Processing| GameRound         | awards points based on result value     | _Points_ added to winning Participant(point)    |
|Processing| Game              | check continue answer                   | answer is true, continue, else quit             |
|Output    | Game              | new game round or game end credit       |                                                 |

This time you will focus on the column `Behavior` and populate the column with methods that will be added to your classes. Additionally you will add code to those methods so they work the way they should.

Here's your code so far, let's extend it, in steps:

```python
class Participant:
  def __init__(self):
    self.points = 0
    self.choice = ""

class GameRound:

class Game:
  def __init__(self):
    self.endGame = False
    self.participant = Participant()
    self.secondParticipant = Participant()
   ```

### Start a game

The first part of the game involves setting it up, which means to instantiate the game itself and take the game to a point where it's waiting for the participants to act.

1. Replace the content of `rock-paper-scissors.py` with this code:

```python
class Participant:
  def __init__(self, name):
    self.name = name
    self.points = 0
    self.choice = ""
  def choose(self):
    self.choice = input("{name}, select rock, paper or scissor: ".format(name= self.name))
    print("{name} selects {choice}".format(name=self.name, choice = self.choice))

class GameRound:
  def __init__(self, p1, p2):
    p1.choose()
    p2.choose()
  def compareChoices(self):
    print("implement")
  def awardPoints(self):
    print("implement")

class Game:
  def __init__(self):
    self.endGame = False
    self.participant = Participant("Spock")
    self.secondParticipant = Participant("Kirk")
  def start(self):
    game_round = GameRound(self.participant, self.secondParticipant)

  def checkEndCondition(self):
    print("implement")
  def determineWinner(self):
    print("implement")

game = Game()
game.start()
```

You've added the methods from your table to each object. The changes you've made can be expressed by a table so it's easier to see what behavior led to what method being added.

|Behavior              |Method              | Actor       |
|----------------------|--------------------|-------------|
|chooses symbol        | choose()           | Participant |
|compares choices      | compareChoices()   | GameRound   |
|awards points         | awardPoints()      | GameRound   |  
|check continue answer | checkEndCondition()| Game        |
|game end credit       | determineWinner()  | Game        |

Most of the behavior in the above table corresponds to methods with similar names. The exception is the _game end credit_ which becomes `determineWinner()`. The reason is that as part of ending a game it's nice if you can check who won and print that out. It's up to you if you want to name this method something else.

1. Run the code by invoking `python3`:

   ```bash
   python3 rock-paper-scissors.py
   ```

   The program produces an output like so:

   ```output
   Spock, select rock, paper or scissor:
   ```

   That output means the program is waiting for you to act.

1. Ensure the program works by selecting `rock` and then press `enter` and then select `paper` and press enter again:

   Your output resembles this text:

   ```output
   Spock, select rock, paper or scissor: rock
   Spock selects rock
   Kirk, select rock, paper or scissor: paper
   Kirk selects paper
   ```

> [!NOTE]
> The solution for this exercise can be found at: [Start a game - solution code](https://github.com/MicrosoftDocs/mslearn-python-oo/blob/main/rock-paper-scissor-0.py?azure-portal=true)

### Implement rules

From the problem description you read that certain choices beats other choices. For example rock beats scissor, scissor beats paper and so on. It's tempting to write code that looks like so:

```python
if choice1 == "rock" and choice2 == "scissor":
  return 1
elif choice1 == "paper" and choice2 == "scissor":
  return -1
else:
  # something else

# and so on
```

It results in a lot of code written and becomes a bit unwieldy. What if the game needs to expand its rule set that might make the code even harder to maintain?

Fortunately there's a better way. A better approach is to think about the rules as a matrix. The idea of using a matrix is to express what combination wins over what other combination. A winning move gets a `1`, a draw a `0` and a loosing move gets a `-1`. Below is a matrix over Rock Paper Scissors:

|Choice   |Rock     |Paper    |Scissor  |
|---------|---------|---------|---------|
|Rock     | 0       | -1      |  1      |
|Paper    | 1       |  0      | -1      |
|Scissor  | -1      |  1      |  0      |

You can implement the above table in python using a multidimensional array like so:

```python
rules = [
 [0, -1, 1],
 [1, 0, -1],
 [-1, 1, 0]
]

rules[0][1] # Rock vs Paper = -1, Paper wins over Rock
```

1. Locate the `Participant` class and the method `toNumericalChoice()`:

   ```python
   def toNumericalChoice(self):
    switcher = {
      "rock": 0,
      "paper": 1,
      "scissor": 2
    }
    return switcher[self.choice]
   ```

   The above method will convert your command-line string input to an integer. It will make it easier to determine who won a round

1. Locate the `GameRound` class and add the `compareChoices()` method:

   ```python
   def compareChoices(self, p1, p2):
     return self.rules[p1.toNumericalChoice()][p2.toNumericalChoice()]
   ```

   The code will enable you to compare two choices and determine the winner.

1. In the same class, add method `getResultAsString()`:

   ```python
   def getResultAsString(self, result):
     res = {
       0: "draw",
       1: "win",
       -1: "loss"
     }
     return res[result]
   ```

   This method is a method that will help determine the result and print an easy to understand text to the screen.

1. Still in the same class, replace the content of `__init__()` with this code:

   ```python
   def __init__(self, p1, p2):
     self.rules = [
       [0, -1, 1],
       [1, 0, -1],
       [-1, 1, 0]
     ]

     p1.choose()
     p2.choose()
     result = self.compareChoices(p1,p2)
     print("Round resulted in a {result}".format(result = self.getResultAsString(result) ))
   ```

   The above code introduces the field `rules`, which contain an implementation of the rules for rock paper scissors. Additionally, the call to `self.compareChoices()` _compares_ the two choices made. Lastly, there's a row that prints reader-friendly result to the screen.

> [!NOTE]
> The solution for this exercise can be found at: [Implement rules - solution code](https://github.com/MicrosoftDocs/mslearn-python-oo/blob/main/rock-paper-scissor-1.py?azure-portal=true)

### Score game

Scoring the game is about assigning points to the correct player after. The winning player gets one point, a draw, or loss gets no points.

1. Locate the `Participant` class and add the method `incrementPoint()`:

   ```python
   def incrementPoint(self):
     self.points += 1
   ```

   > [!TIP]
   > Introducing a method to change an attribute is first step towards encapsulation. If you want, try changing the `points` field to `__points__` to _hide_ the member from the outside to practice encapsulation.

1. Locate the `GameRound` class and add the following code to the end of the `__init()__` method:

   ```python
   if result > 0:
     p1.incrementPoint()
   elif result < 0:
     p2.incrementPoint()
   ```

> [!NOTE]
> The solution for this exercise can be found at: [Score game - solution code](https://github.com/MicrosoftDocs/mslearn-python-oo/blob/main/rock-paper-scissor-2.py?azure-portal=true)

### Add continuation query

A continuation query is a question at the end of the game round asking the player if they want to continue. If the user chooses not to continue it's nice to output the current results and the winner, if any.

1. Locate the `Game` class and implement the method `determineWinner()`:

   ```python
   def determineWinner(self):
     resultString = "It's a Draw"
     if self.participant.points > self.secondParticipant.points:
       resultString = "Winner is {name}".format(name=self.participant.name)
     elif self.participant.points < self.secondParticipant.points:
       resultString = "Winner is {name}".format(name=self.secondParticipant.name)
     print(resultString)
   ```

1. In the same class, implement the method `checkEndCondition()`:

   ```python
   def checkEndCondition(self):
     answer = input("Continue game y/n")
     if answer == 'y':
       GameRound(self.participant, self.secondParticipant)
       self.checkEndCondition()
     else:
       print("Game ended, {p1name} has {p1points}, and {p2name} has {p2points}".format(p1name = self.participant.name, p1points= self.participant.points, p2name=self.secondParticipant.name, p2points=self.secondParticipant.points))
       self.determineWinner()
       self.endGame = True
   ```

1. In the same class, replace the code for the `start()` method with this code:

   ```python
   def start(self):
     while not self.endGame:
       GameRound(self.participant, self.secondParticipant)
       self.checkEndCondition()
   ```

1. Run the command `python3 rock-paper-scissors.py`, to test out your program:

   ```bash
   python3 rock-paper-scissors.py
   ```

   Select `rock` and `paper` as inputs and type `n` when asked to continue.

   Your output looks similar to the below text:

   ```output
   Spock, select rock, paper or scissor: rock
   Spock selects rock
   Kirk, select rock, paper or scissor: paper
   Kirk selects paper
   Round resulted in a loss
   Continue game y/n: n
   Game ended, Spock has 0, and Kirk has 1
   Winner is Kirk
   ```

> [!NOTE]
> The solution for this exercise can be found at: [Continuation query - solution code](https://github.com/MicrosoftDocs/mslearn-python-oo/blob/main/rock-paper-scissor-3.py?azure-portal=true)

Congrats, you did it. You've implemented an OOP version of Rock, Paper, Scissors.
