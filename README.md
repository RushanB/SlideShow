# SlideShow

A Camera App that lets you edit photos and view them in a "SlideShow".

# Timeline

Started the initial research and began on Saturday May 28th at 10:00AM. We presented the app less than 6 days later on June 2nd at 2:00 PM.

# User Case

- A user has to first sign up for the application and then log in so then the data will automatically generate the User's profile page.
- The user can then view his profile statistics or start a new project or "slideshow" where they can take photo's from their working camera, import them from their photo library or search Flickr's API to add the photo's into their working project.
- After a user has added his photo, they can add text labels with various colors scheme's onto the image at any point on the image. The user can also attach notes onto another slide which they can then view in the "slideshow" feature.
- After the user has placed photos into a project, they can move the order of the slide show around as they please by dragging and dropping. The user can also delete an image by selecting it and clicking on the delete icon.
- When the user is satisfied with his working project, he can tap on it to play a slideshow with all his images displaying in a sequence. The user can tap onto the image to view his notes if he has added any.

# UIImagePicker

This is used to fetch photos into the photo editor from the user's camera or photo library.

# Flickr API

This is used to get photos from Flickr's database and allow the user edit the images and save them into a project.

# QuartzCore

This is used to add text labels onto the image without intializing a property for a textfield.

# CoreData

This is used to store the information for users, slideshows and photos. Different USERS will have many SLIDESHOWS which will contain many PHOTOS.
