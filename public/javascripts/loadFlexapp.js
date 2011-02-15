document.observe("dom:loaded", function() {

Event.observe('signinForm', 'submit', onSubmit);

function thisMovie(movieName) {
      if (navigator.appName.indexOf("Microsoft") != -1) {
          return window[movieName];

      } else {
          return document[movieName];
      }
}

function onSubmit()
{

 thisMovie("HeatMap").onSubmit();

}
