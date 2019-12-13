// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .
//= require rails-ujs
//= require activestorage
//= require turbolinks

// Select elements in the form search
function getSelectValue() {
  var sportType = document.getElementById("sport_element").value;
  console.log(sportType);
  var date = document.getElementById("date_element").value;
  console.log(date);
  var time = document.getElementById("time_element").value;
  console.log(time);
  var city = document.getElementById("city_element").value;
  console.log(city);
}

// Take value of search in var
function process() {
  var sportType = document.getElementById("sport_element").value;
  var date = document.getElementById("date_element").value;
  var time = document.getElementById("time_element").value;
  var city = document.getElementById("city_element").value;
  display_values(city, date, time, sportType);
}

// Print informations of form search
function display_values(city, date, time, sportType) {
  document.getElementById("city").innerHTML = city;
  console.log(document.getElementById("city"));
  document.getElementById("sportType").innerHTML = sportType;
  console.log(document.getElementById("sportType"));
  document.getElementById("date").innerHTML = date;
  console.log(document.getElementById("date"));
  document.getElementById("time").innerHTML = time;
  console.log(document.getElementById("time"));
}
