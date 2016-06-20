Booking.destroy_all
Company.destroy_all
User.destroy_all
# AdminUser.destroy_all

#USERS
gag = User.create!(email: "contact@mecatechnic.ninja", password: "12345678", password_confirmation: "12345678")
dj =  User.create!(email: "contact@deezer.ninja", password: "12345678", password_confirmation: "12345678")
thibaut =  User.create!(email: "contact@ikomobi.ninja", password: "12345678", password_confirmation: "12345678")
damien =  User.create!(email: "contact@mutualab.ninja", password: "12345678", password_confirmation: "12345678")
cecile = User.create!(email: "contact@lacoroutine.ninja", password: "12345678", password_confirmation: "12345678")
thomas = User.create!(email: "contact@doumit.ninja", password: "12345678", password_confirmation: "12345678")
mec = User.create!(email: "contact@ecotaco.ninja", password: "12345678", password_confirmation: "12345678")
julien = User.create!(email: "contact@ztp.ninja", password: "12345678", password_confirmation: "12345678")

# COMPANIES
mecatechnic = gag.create_company!(name: "mecatechnic", siret:"40483304800022", address: "3 rue Paul Langevin", city: "Tourcoing", postcode: "59599", description: "Spécialiste de pièces détachées VW. Bossez au milieu des belles bagnoles !", coffee: false, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/mecatechnic.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: true, open_sunday: false, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
deezer = dj.create_company!(name: "Deezer", siret:"40483304800022", address: "108 rue Nationale", city: "Lille", postcode: "59000", description: "N°1 français en streaming musical. Bossez en écoutant la musique à donf !", coffee: true, wifi: true, printer: false, scanner: false, picture: File.open(Rails.root.join("db/seeds/images/deezer.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: false, open_sunday: false, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
ikomobi = thibaut.create_company!(name: "ikomobi", siret:"40483304800022", address: "Parc Europe", city: "Marcq-en-Baroeul", postcode: "59700", description: "Agence mobile internationale. Développement d'applications natives et de sites mobiles.", coffee: true, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/ikomobi.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: false, open_sunday: false, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
mutualab = damien.create_company!(name: "Mutualab", siret:"40483304800022", address: "19 rue Nicolas Leblanc", city: "Lille", postcode: "59000", description: "Plus grand espace de coworking de Lille.", coffee: true, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/mutualab.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: true, open_sunday: true, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
coroutine = cecile.create_company!(name: "La Coroutine", siret:"40483304800022", address: "8 rue Molière", city: "Lille", postcode: "59000", description: "Espace de coworking posé. Si t'as besoin d'aide en ruby, Cécile n'est pas loin. Rejoins-nous !", coffee: true, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/coroutine.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: true, open_sunday: true, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
doumit = thomas.create_company!(name: "Doumit", siret:"40483304800022", address: "18 rue Basse", city: "Lille", postcode: "59000", description: "Agence web spacialisée en RoR. T'es dans une cave mal éclairée mais il y a moyen de se marrer !", coffee: true, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/doumit.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: false, open_sunday: false, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
ecotaco = mec.create_company!(name: "EcoTaco", siret:"40483304800022", address: "Euratechnologies,165 avenue de Bretagne", city: "Lille", postcode: "59000", description: "Service web orienté mobilité.", coffee: false, wifi: true, printer: false, scanner: false, picture: File.open(Rails.root.join("db/seeds/images/ecotaco.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: false, open_sunday: false, start_time_am: "8:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "7:00 PM", phone_number: "0606060606")
ztp = julien.create_company!(name: "ZTP", siret:"40483304800022", address: "34 rue d'Athènes", city: "Lille", postcode: "59000", description: "A deux pas de la gare Lille Europe, meilleur incubateur du Nord !", coffee: true, wifi: true, printer: true, scanner: true, picture: File.open(Rails.root.join("db/seeds/images/ztp.jpg")), open_monday: true, open_tuesday: true, open_wednesday: true, open_thursday: true, open_friday: true, open_saturday: false, open_sunday: false, start_time_am: "9:00 AM", end_time_am: "12:00 PM", start_time_pm: "2:00 PM", end_time_pm: "6:00 PM", phone_number: "0606060606")

# MECATECHNIC DESKS
mecatechnic_open_space = mecatechnic.desks.create!(kind: "open_space", quantity: 4, description: "Un open space entre les coccinnelles et combis. Un peu de bruit généré par le comptoir de vente et les téléphones.", half_day_price: 9, daily_price: 15, weekly_price: 50, activated: true, desktop: true, number: 1)
mecatechnic_closed_office1 = mecatechnic.desks.create!(kind: "closed_office", quantity: 1, description: "Deux chaises et un bureau. Légérement décoré. Prise 220v", half_day_price: 22, daily_price: 35, weekly_price: 110, activated: true, desktop: true, number: 2)
mecatechnic_closed_office2 = mecatechnic.desks.create!(kind: "closed_office", quantity: 1, description: "Deux chaises et un bureau. Légérement décoré. Prise 220v", half_day_price: 16, daily_price: 25, weekly_price: 80, activated: true, desktop: false, number: 1)
mecatechnic_meeting_room = mecatechnic.desks.create!(kind: "meeting_room", quantity: 1, description: "Salle 6 places avec un champignon téléphonique pour les conf calls.", half_day_price: 35, daily_price: 60, weekly_price: 200, activated: true, number: 1, call_conference: true)

# DEEZER DESKS
deezer_open_space = deezer.desks.create!(kind: "open_space", quantity: 5, description: "Open space avec canapés, transats, bureaux, chaises, standing-desks.", half_day_price: 12, daily_price: 20, weekly_price: 80, activated: true, number: 1)

# IKOMOBI DESKS
ikomobi_open_space = ikomobi.desks.create!(kind: "open_space", quantity: 4, description: "Open space avec bureaux, chaises, écrans, standing-desks.", half_day_price: 10, daily_price: 18, weekly_price: 80, activated: true, number: 1)
ikomobi_closed_office = ikomobi.desks.create!(kind: "closed_office", quantity: 1, capacity: 2, description: "Deux chaises et un bureau. Légérement décoré. Prise 220v", half_day_price: 20, daily_price: 30, weekly_price: 100, activated: true, number: 1)
ikomobi_closed_office = ikomobi.desks.create!(kind: "closed_office", quantity: 1, capacity: 3, description: "Trois chaises et un bureau. Equipé d'une TV. Légérement décoré. Prise 220v", half_day_price: 25, daily_price: 40, weekly_price: 130, activated: true, number: 2, tv:true)
ikomobi_meeting_room = ikomobi.desks.create!(kind: "meeting_room", quantity: 1, description: "Salle 12 places avec un champignon téléphonique pour les conf calls et écran/enceintes/micros pour visio-conférences.", half_day_price: 45, daily_price: 80, weekly_price: 300, activated: true, number: 1, tv: true, call_conference: true, desktop: true)

# MUTUALAB DESKS
mutualab_open_space = mutualab.desks.create!(kind: "open_space", quantity: 15, description: "Open space avec bureaux, chaises, écrans, standing-desks.", half_day_price: 10, daily_price: 16, weekly_price: 50, activated: true, number: 1)
mutualab_closed_office1 = mutualab.desks.create!(kind: "closed_office", quantity: 1, capacity: 1 , description: "Une chaise et un bureau. Légérement décoré. Prise 220v", half_day_price: 18, daily_price: 30, weekly_price: 100, activated: true, number: 1)
mutualab_closed_office2 = mutualab.desks.create!(kind: "closed_office", quantity: 1, capacity: 2, description: "Deux chaises et un bureau. Ecran et projecteur dispo. Légérement décoré. Prise 220v", half_day_price: 30, daily_price: 50, weekly_price: 150, activated: true, number: 2, tv: true, projector: true)
mutualab_closed_office3 = mutualab.desks.create!(kind: "closed_office", quantity: 1, capacity: 2, description: "Deux chaises et un bureau. Ecran et projecteur dispo. Légérement décoré. Prise 220v", half_day_price: 30, daily_price: 50, weekly_price: 150, activated: true, number: 3, tv: true, projector: true)
mutualab_meeting_room1 = mutualab.desks.create!(kind: "meeting_room", quantity: 1, capacity: 5 , description: "Salle 5 places avec un champignon téléphonique pour les conf calls et écran/enceintes/micros pour visio-conférences.", half_day_price: 40, daily_price: 70, weekly_price: 250 , activated: true, number: 1, call_conference: true, tv: true)
mutualab_meeting_room2 = mutualab.desks.create!(kind: "meeting_room", quantity: 1, capacity: 8 , description: "Salle 8 places avec un champignon téléphonique pour les conf calls et écran/enceintes/micros pour visio-conférences.", half_day_price: 40, daily_price: 70, weekly_price: 250, activated: true, number: 2, call_conference: true, tv: true, desktop:true)
mutualab_meeting_room3 = mutualab.desks.create!(kind: "meeting_room", quantity: 1, capacity: 14 , description: "Salle 14 places avec un champignon téléphonique pour les conf calls et écran/enceintes/micros pour visio-conférences.", half_day_price: 55, daily_price: 90, weekly_price: 300, activated: true, number: 3, call_conference: true, tv: true, desktop:true)

# COROUTINE DESKS
coroutine_open_space = coroutine.desks.create!(kind: "open_space", quantity: 15, description: "Open space avec bureaux, chaises, écrans, standing-desks.", half_day_price: 6, daily_price: 10, weekly_price: 50, activated: true, number: 1)
coroutine_closed_office = coroutine.desks.create!(kind: "closed_office", quantity: 1, description: "Deux chaises et un bureau. Légérement décoré. Prise 220v", half_day_price: 15, daily_price: 25, weekly_price: 100, activated: true, number: 1)
coroutine_meeting_room = coroutine.desks.create!(kind: "meeting_room", quantity: 1, description: "Salle 6 places avec un champignon téléphonique pour les conf calls.", half_day_price: 35, daily_price: 60, weekly_price: 200, activated: true, number: 1)

# DOUMIT DESKS
doumit_open_space = doumit.desks.create!(kind: "open_space", quantity: 1, description: "Open space avec bureaux, chaises, écrans.", half_day_price: 6, daily_price: 10, weekly_price: 50, activated: true, number: 1)

# ECOTACO DESKS
ecotaco_open_space = ecotaco.desks.create!(kind: "open_space", quantity: 1, description: "Open space 'collé-serré' avec bureaux, chaises, écrans.", half_day_price: 7, daily_price: 12, weekly_price: 50, activated: true, number: 1)

# COFACTORY DESKS
ztp_open_space = ztp.desks.create!(kind: "open_space", quantity: 15, description: "Open space avec bureaux, chaises, écrans, standing-desks et de la bonne musique.", half_day_price: 16, daily_price: 30, weekly_price: 100, activated: true, number: 1)
ztp_meeting_room = ztp.desks.create!(kind: "meeting_room", quantity: 1, description: "Salle 12 places avec un champignon téléphonique pour les conf calls et écran/enceintes/micros pour visio-conférences.", half_day_price: 50, daily_price: 90, weekly_price: 300, activated: true, number: 1, tv:true, call_conference: true)

# ADMIN USER
