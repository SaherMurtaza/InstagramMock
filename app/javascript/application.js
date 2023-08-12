// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "jquery"
// app/assets/javascripts/application.js

$(document).on('click', '.like-button', function() {
    var postId = $(this).data('post-id');
  
    if ($(this).hasClass('unliked')) {
      $.ajax({
        type: 'DELETE',
        url: '/posts/' + postId + '/destroy_like',
        success: function(data) {
          // Handle success, e.g., update UI
        },
        error: function() {
          // Handle error
        }
      });
    } else {
      $.ajax({
        type: 'POST',
        url: '/posts/' + postId + '/create_like',
        success: function(data) {
          // Handle success, e.g., update UI
        },
        error: function() {
          // Handle error
        }
      });
    }
  });
  