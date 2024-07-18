# Catch The Egg!

#### Video Demo:  <https://youtu.be/ObS63MZ57Ec>

#### Description: 
My game, "**Catch The Egg!**", is a casual arcade game where you, the player, control a bucket and have to catch falling eggs. The speed of the eggs increases with each level, making it more and more difficult to catch all the eggs without letting one go past the screen. For each egg you catch, a point is added. Get to 50 points, and you've won the game. I decided to make a game for my CS50 final project because I've only ever done web development and simple animations and I wanted to branch out. I don't know exactly what aspect of coding I want to do in the future, so I want to try them all out, and a video game sounded awesome. I had to learn a whole new language for this, Lua. I had never used it or LOVE before, and while I'm still not skilled at it, I am now able to recognize it and code simple games with it.

## My main.lua File

#### To start, before explaining my functions: 
I would like to say that, while long and difficult, the most challenging thing for my game would be having to make the collision function myself. I debated whether or not to use a library, but most didn't support ellipses. I could have searched more for it, but I decided to make my own to challenge myself and become familiar with how it works through all the research I had to do.

### love.load()
My love.load function takes care of initiating various variables for the egg, counting the points, game over status, and the current level. It sets up the window title, dimensions, background image, bucket sprite, and loads the music.

### love.update()
The love.updates function takes care of handling music playback, game over conditions, user input to move the bucket sprite, the egg falling, the level changing depending on the amount of points, and collision detection.

### love.draw()
The love.draw function draws everything on the screen. It has all the information for the instructions screen, the gameover screen, and the win screen. During gameplay, it displays the background, egg, bucket sprite, number of points, and the current level the user is on.

### love.mousepressed(x, y, button, istouch, presses), RandomEgg(), and love.keypressed(key)
These functions are self-explanatory. Love.mousepressed handles the start button during the instructions screen so that when it's clicked, the game starts, RandomEgg() is in charge of spawning random eggs, and love.keypressed(key) is responsible for restarting the game when 'R' is pressed.

## How to Play
Eggs will drop, and you have to catch them using the bucket. Move the bucket using the 'A' and 'D' keys or the left and right arrow keys. Don't let the eggs fall off the screen, or else it's game over. The game gets more difficult the higher the level, as the eggs start falling faster. Reach 50 points to complete all three levels and win the game.

## Installation
I haven't published my game yet, but I may in the future. If you like, anyone is welcome to take the code and play the game themselves. If you want to publish it yourself, do so as long as you follow the license.

## Credits
- Background image from **Thalita Alves at Pinterest (@althalita_)**.
- Music: **"The Entertainer" by Kevin MacLeod (incompetech.com), licensed under Creative Commons: By Attribution 4.0 License.**

## License
** This project is licensed under the Creative Commons Attribution 4.0 International License (CC-BY 4.0). See the [LICENSE](LICENSE) file for details. **
