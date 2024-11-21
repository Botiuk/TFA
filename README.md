# TFA

TFA is the internet home for football fan firm "Terno Field Army". It's an old, now unused site, but rewriting its backend with RoR, and adding new functionality was interesting for me. Many years ago I help wrote frontend and made some design elements for this site.

Built with: Rails 7.2.1.2, Ruby 3.3.5, postgres, Turbo, Stimulus, Bootstrap, Cloudinary, Trix editor, devise, cancancan.

Test with: RSpec, factory_bot_rails and faker.

Code style checking: RuboCop and his special cops.

Unregistered users can read news, and look at the calendar with matches of the team, fan attributes, videos for learning fan chants and match reports, photo galleries, and the rating of fans for a count of visited "on tour" matches.

After registration, the user can edit or delete his profile, and look detailing information about matches in the calendar - match protocol, fans' photos, and their videos from this match. Also the main video chapter is now available button to show each corresponding football match.

If the admin changed the role registered user to 'fan', it now can read the personal page of each fan from rating. On this page is information about each match in which the current fan was. Also, information about all the fans on the match is available on the match page.

Admin created with db:seed. He has additional functionality. Only he creates news, fan attributes, seasons, teams, stadiums, and tournaments which need to create football matches. Also, he can add videos, create fan profiles for rating, add fans to matches, and change user roles.