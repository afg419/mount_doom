Journey to Mount Doom is a basic online single player RPG.  Select a character from the fellowship of Lord of the Rings and  purchase weapons, armor, food, medicines, and magical items while travelling from location to location on the way to Mordor and Mount Doom.    

Link: `http://mount-doom.herokuapp.com/`    

The game was made using ruby on rails, with front end assistance lent by JQuery and JS.  To get and run the game locally, simply clone this repository:  
`$ git clone https://github.com/afg419/the_pivot.git`  
`$ bundle`    

Create and seed local database:  
`$ rake db:create && rake db:migrate && rake db:seed`    

Run the server at url `localhost:3000` locally with:  
`$ rails server`    

Run development/test tests with:  
`$ rake test`



