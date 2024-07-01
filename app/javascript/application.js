// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import 'bootstrap';
import 'jquery';
//import '@fortawesome/fontawesome-free/js/fontawesome';
import "./modal_submit_user"

// app/javascript/application.js
Turbo.StreamActions.redirect = function () {
    Turbo.visit(this.target);
};