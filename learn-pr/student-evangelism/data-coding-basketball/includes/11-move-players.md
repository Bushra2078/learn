This web app wouldn't be useful if the coach couldn't make a decision about which players were taking a water break and which were on the court. Now that the coach can see the PER for each player for the first quarter, we want to help the coach visualize what the average PER for a starting line up would be as they choose move players between the court and the bench.

## Write the functionality to move players 

This unit will fill in the `movingPlayers()` function:

```javascript
// This function is called each time a player button is clicked. A player
// button being clicked indicates the players is either moving to the court
// or to the bench for a water break
function movingPlayers() {

}
```

But first, we want to make sure the coach doesn't make changes to the players during a quarter. While in a real basketball game that is definitely OK to do, in this version we only have PER stats for each quarter start so we want to limit the functionality. 

```javascript
    // Do not let the coach change players during a quarter
    if(quarterInPlay) {
        return;
    }
```

We can now leverage the HTML structure to figure out where the player currently is; the bench or the court. We know that the buttons were initially placed on a div with the id "playersOnBench", so we can start by testing if the player is currently on the bench, meaning the coach is trying to move the player to the court.

```javascript
    // Get the div where this button currently is (either bench or court)
    var parentDiv = this.parentElement;

    // Check if the player is currently on the bench
    if(parentDiv.id == 'playersOnBench') {
```

Within the if-statement, we need to make one check before we do anything else: You can only have 5 players on the court at any given time, so we want to make sure the coach isn't trying to add additional players. In this case, we will just alert the coach that this isn't allowed and not actually move the player.

```javascript
    // If there are already 5 players on the court, don't let the player 
        // move to the court, alert the coach that there are enough players
        if(playersOnCourt >= maxPlayersOnCourt){
            alert("You can only have " + maxPlayersOnCourt + " players on the court at a time.");
        }
```

If there is room on the court for the player, then we want to do a few things:
1. Increase the count for number of players on the court
2. Get the player's PER for the current quarter
3. Calculate the average PER for all of the players currently on the court
4. Update the Current PER for the court 
5. Move the player to the court

```javascript
        else {
            // If there is room on the court, update the number of players on 
            // the court, and update the average PER for the quarter based on
            // this player moving to the court
            playersOnCourt++;
            quarterPER += playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
            document.getElementById('currentPER').innerHTML = "Current PER: "+ quarterAvePER.toPrecision(4);
            
            // Move the player to the court
            document.getElementById('playersOnCourt').appendChild(this);
        }
```

Next, we want to support the coach moving players from the bench back to the court. This can all be in an else-statement because there are only two places a player can be, the court or the bench. So we will do a couple of things in this else statement:
1. Decrement the count of players on the court
2. Calculate the PER for the players left on the court and if there aren't any more players on the court, set the PER to 0
3. Display the PER to the coach
4. Move the player to the bench

```javascript
    else {
        // If the player is being taken off the court for a water break, decrement
        // the number of players on the bench and remove the player's PER from the
        // average
        playersOnCourt--;

        if(playersOnCourt != 0) {
            quarterPER -= playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
        }
        else {
            // If there are no more players on the court, set the values to 0
            quarterPER = 0;
            quarterAvePER = 0;
        }

        // Update the PER average. This could result in a zero value if your team is particularly tired
        document.getElementById('currentPER').innerHTML = "Current PER: "+ quarterAvePER.toPrecision(4);

        // Move the player to the bench
        document.getElementById('playersOnBench').appendChild(this);
    }
```

## Review the final movingPlayers code

The entire `movingPlayers()` function should be like this:
```javascript
// This function is called each time a player button is clicked. A player
// button being clicked indicates the players is either moving to the court
// or to the bench for a water break
function movingPlayers() {
    // Do not let the coach change players during a quarter
    if(quarterInPlay) {
        return;
    }

    // Get the div where this button currently is (either bench or court)
    var parentDiv = this.parentElement;

    // Check if the player is currently on the bench
    if(parentDiv.id == 'playersOnBench') {
        // If there are already 5 players on the court, don't let the player 
        // move to the court, alert the coach that there are enough players
        if(playersOnCourt >= maxPlayersOnCourt){
            alert("You can only have " + maxPlayersOnCourt + " players on the court at a time.");
        }
        else {
            // If there is room on the court, update the number of players on 
            // the court, and update the average PER for the quarter based on
            // this player moving to the court
            playersOnCourt++;
            quarterPER += playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
            document.getElementById('currentPER').innerHTML = "Current PER: "+ quarterAvePER.toPrecision(4);
            
            // Move the player to the court
            document.getElementById('playersOnCourt').appendChild(this);
        }
    }
    else {
        // If the player is being taken off the court for a water break, decrement
        // the number of players on the bench and remove the player's PER from the
        // average
        playersOnCourt--;

        if(playersOnCourt != 0) {
            quarterPER -= playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
        }
        else {
            // If there are no more players on the court, set the values to 0
            quarterPER = 0;
            quarterAvePER = 0;
        }

        // Update the PER average. This could result in a zero value if your team is particularly tired
        document.getElementById('currentPER').innerHTML = "Current PER: "+ quarterAvePER.toPrecision(4);

        // Move the player to the bench
        document.getElementById('playersOnBench').appendChild(this);
    }
}
```

## Test the functionality of moving players

We can now refresh the local web app in the browser and test the functionality we just built. You should be able to click on up to 5 characters that are on the bench and move them over to the court:

![Demonstrating moving players to the court](../media/move-to-court.png)

You should test this functionality:
- Try to add more than 5 players to the court and make sure the alert pops up
- Add players to the court then move all of them back to the bench
- Make sure the average PER for players on the court is accurate depending on the stats for the players for the given quarter
