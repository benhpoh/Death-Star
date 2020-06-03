require "pg"

def run_sql(sql)
    conn = PG.connect(dbname: 'galaxy')
    records = conn.exec(sql)
    conn.close
    records
end

def list_all_planets()
    run_sql("SELECT * FROM planets;")
end

def create_planet(name, distance, moon_count, image_url)
    run_sql("INSERT INTO planets (name, distance, moon_count, image_url) VALUES ('#{name}', #{distance}, #{moon_count}, '#{image_url}');")
end

def list_planet_by_id(id)
    run_sql("SELECT * FROM planets WHERE id = #{id};")[0]
end

def update_planet_by_id(id, name, distance, moon_count, image_url)
    run_sql("UPDATE planets SET name = '#{name}', distance = #{distance}, moon_count = #{moon_count}, image_url = '#{image_url}' WHERE id = #{id};")
end

def delete_planet_by_id(id)
    run_sql("DELETE FROM planets WHERE id = #{id};")
end

def create_random_planet()
    
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