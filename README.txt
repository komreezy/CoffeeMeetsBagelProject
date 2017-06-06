I wanted to have something in the project that kind of went through the features of the project & and some of my decisions in case you needed it!

I used MVVM as the architecture of the app with and API Manager and a View Model to retrieve and present the data for the Table View.

Since the data was from JSON, I faked it as much as I could up until the point where I would make the URL request and I just loaded the team data from the Bundle. 

My gradient code was just something fun I was trying to do. There is a whole complicated way to set a gradient on a view in Swift, so I found an article that taught me how to create an easy interface to do it. I broke that code up into cleaner separate files & I added a calculateGradient(with progress) function that would take in a percentage & a set of colors as RGB structs and then distribute which part of the gradient you were at based on the progress percentage. I made this so I could hook it up to the Table View's scroll view and the gradient would change as you're scrolling.

The transition animator was also really fun to make. This is the reason I made the cells alternate sides from left to right so the animation to the user profile would look good. I was thinking that for an actual app design it'd probably be best to keep them all on one side haha. I just took the frame of the profile image in the cell that you tapped on in the application window's coordinate space and animated that frame in the transition context to where it would be in the Employee Detail View Controller and then I would get rid of it and fade everything else in.

This is where everything ties in together in the transition by saving the current gradient values and putting that in the transition context & as the background of the Employee Detail View Controller so that the detail view has the background gradient the same as the background the moment you tapped the cell to get there.

I wrote some fake tests for some extra work but since the data is being loaded from JSON they're not that useful haha.

p.s.
Thank you guys for giving me an open ended coding challenge. It was really fun to try to think of ways to be creative.