# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'bootstrap-sprockets', to: 'bootstrap-sprockets.js', preload: true
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin 'jquery', to: 'jquery.min.js', preload: true
pin 'jquery_ujs', to: 'jquery_ujs.js', preload: true
pin 'popper', to: 'popper.js', preload: true
pin 'activestorage', to: 'activestorage.js'
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.esm.js'
pin_all_from 'app/javascript/custom', under: 'custom'
