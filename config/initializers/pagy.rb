require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 10        # items per page
Pagy::DEFAULT[:overflow] = :last_page