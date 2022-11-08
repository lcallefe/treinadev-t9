# Pin npm packages by running ./bin/importmap

pin "application", preload: true
<<<<<<< HEAD
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
=======

pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
