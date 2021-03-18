Let's update your display to highlight items that are almost sold out and to display the appropriate button labels for booking a trip. If the seating class offers "early bird" booking, you'll set the button label appropriately. If early bird booking isn't available, you'll prompt the user to book now. If fewer than 10 seats are available, you'll display a message saying that the class is almost sold out.

## Add the code to update the display

1. In Visual Studio Code, open *index.html*.
1. Below the commented line that reads "More to come," add the following HTML:

    ```html
    <!-- More to come -->
    <button v-if="productClass.earlyBird" class="button">Book early bird!</button>
    <button v-else class="button">Book now!</button>

    <div v-show="productClass.seatsAvailable < 10">Almost sold out!</div>
    ```

## Test the display

1. Save all files.
1. Return to the browser. The display should now be updated. It it isn't, refresh the page. Your page should now look like the following screenshot:

   ![Screenshot of updated display showing buttons and text.](../media/conditional.png)
