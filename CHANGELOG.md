## 1.0.1
- Merged https://github.com/caseyryan/flutter_instagram_storyboard/pull/6 
Added duration for each story
Added showAddButton for adding your story
Manage long press and tap for own story and other user story
Added markAsWatched callback
Updated listener that return storyId which return storyId with current index like ( 1-0 , 1-1 )
Thanks to https://github.com/shivbo96

## 0.0.8
- Button list is disabled if buttonDatas is empty. In this case 
- it will return SizedBox.shrink()
## 0.0.6
- Buttons can be conditionally enabled or disabled now by calling
their "isVisible" callback
## 0.0.5
- Added removeListener call to the story timeline controller
## 0.0.4
- Added story watched contract
## 0.0.3
- StoryList now can accept listHeight and buttonWidth paramters
- A child of StoryButton is now stacked upon the button but not inside whic allows it to overlap the bounds of the visible button part (see example)
## 0.0.1
- Initial release
