// GridView builder--> it is same as listview builder but it saves the time efficiency(i.e. performance) by just rendering the things which are on the screen and does'nt render which are off the screen, which makes the app run faster.
// mixin --> it is same as creating class but instead of class we write mixin keyword,it is similar to creating class,  but it can be used as mulitple inheritance that is we can use mixin to use multiple inheritance(like structure) where as class does'nt provide it,
// mixin can be used as utility,functionality in the program whereas extends can be used as the main logical connection between the classes
// ChangeNotifierProvider --> is also used to dispose the old data which has been replaced by other/same widget which is been used to avoid memory leak.
// Consumer --> is also similar to Provider.of but the difference is that Provider.of is used to rebuild the entire widget whenever the Provider.of is called which cost us to reduce the performance of our app , whereas Consumer is used to render the only part which ever gets updated instead of updating the entire build method and if we dont' want a particular widget to be rebuild then we can use child widget inside Consumer Widget to avoid the rebuilding.
      
// to show a specific symbol we should use '\$' before adding our symbol.
//spacer() --> is used to adjust the elements on the lefthand and righthand side
// 'as' in the import module is used when we are going to use the name of the library in many instance then instead of writing long names we can use the shortcut by using 'as' keyword.
// 'show' is the same 'as' keyword but a major difference is that it will call the specific function / object instead of calling the entire class .
// Dismissible --> is a animated UI built in flutter which is used to swipe the elements or delete it from the list.
// NetworkImage,AssetImage are the ones which is used to yield the image i.e. to get the image from the url it is used instead of Image.asset or Image.network because the NetworkImage,AssetImage are the objects and are not widgets they are just used to fetch the image and pass the data to backgroundImage i.e. CircleAvatar.
// After creating focusNode we need to dispose it because it can leads to memory leak.


            