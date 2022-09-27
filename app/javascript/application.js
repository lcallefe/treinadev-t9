//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.mask
//= require jquery.inputmask
//= require jquery.inputmask.extensions
//= require jquery.inputmask.numeric.extensions
//= require jquery.inputmask.date.extensions
//= require('inputmask');
$(document).on('turbolinks:load', function () {
    var im = new Inputmask('9.999.999/9999-99');
    var selector = $('#supplier_registration_number');
    im.mask(selector);
  });
