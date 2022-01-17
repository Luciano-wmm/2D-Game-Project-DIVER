# Diver Game with Love2D and Lua
#### Video Demo:  https://youtu.be/x6SEqXRc68M
#### Description:
So, we have the file collision.lua that provides the function to detect when two assets touch each other on the screen.
This function is called in our main file, main.lua.

We get and store in variables our screen size, which will be used in future functions to position the assets.

We have 3 main functions inside this file: .load(), .update() and .draw().
The first one "loads" the items that will form our game.
The second is the frame update: what happens on the screen with each new frame.
The third "loads" the items that will be displayed on the game screen.

We load a random starting point for some variables, in this case the OS time.

We set the initial score to 0.
We indicate the paths for the background image, for the game sounds, and for the sprites:
All the assets used (sounds and images) are from free game assets websites.
The diver has the starting position on the left of the screen.
The star and the shark have their delay time set between two occurrences.

In the .update() function we indicate that the diver's motion functions and the star and shark functions will be updated with each new frame.

In the .draw() function, we "print" the background, the scoreboard, and the images for the sprites, according to positions they should take from their own creation functions.

The function of moving the diver is possible by using the up and down arrow keys on the keyboard. His position is "locked" by the upper and lower limits of the screen.

Each new star is created when its delay is reached.
The position on the vertical axis is randomly generated. The position on the horizontal axis is updated every frame, so that the stars appear in the right corner of the screen and slide toward the diver on the left of the screen.
When a star reaches the left edge of the screen it disappears. The scoreboard is not updated.
When a star collides with the diver, the score adds 1 point, and the sound of a coin is played.

For the sharks, it's the same logic,
Each new shark is created when its delay is reached.
The position on the vertical axis is randomly generated. The position on the horizontal axis is updated every frame, so that the sharks appear in the right corner of the screen and slide toward the diver on the left of the screen.
When a shark reaches the left edge of the screen it disappears. The scoreboard is not updated.
When a shark collides with the diver, the score decreases 1 point, and the sound of the bite is played.