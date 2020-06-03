require_relative "../models/planets"

print "Number of planets to create: "

planet_number = gets.chomp.to_i

planet_number.times do
    
    name = %w{Dagobah Hoth Coruscant Tatooine Naboo Alderaan Scarif Ilum Mustafar}
    distance = rand(0..50000)
    moon_count = rand(0..5)
    image_url = [
        'https://vignette.wikia.nocookie.net/starwars/images/4/48/Dagobah_ep3.jpg',
        'https://vignette.wikia.nocookie.net/starwars/images/1/1d/Hoth_SWCT.png',
        'https://vignette.wikia.nocookie.net/starwars/images/8/84/CoruscantGlobeE1.png',
        'https://vignette.wikia.nocookie.net/starwars/images/b/b0/Tatooine_TPM.png',
        'https://vignette.wikia.nocookie.net/starwars/images/4/4a/Alderaan.jpg',
        'https://vignette.wikia.nocookie.net/starwars/images/6/6d/Scarif_SWCT.png',
        'https://vignette.wikia.nocookie.net/starwars/images/a/af/Mustafar_DB.png'
    ]

    create_planet(name.sample, rand(0..50000), rand(0..5), image_url.sample)
end