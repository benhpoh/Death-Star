require "pg"
require "bcrypt"

def run_sql(sql)
    conn = PG.connect(dbname: 'galaxy')
    records = conn.exec(sql)
    conn.close
    records
end

def list_all_users()
    run_sql("SELECT * FROM users;")
end

def create_user(name, password)
    digested_password = BCrypt::Password.create(password)
    run_sql("INSERT INTO users (name, digested_password) VALUES ('#{name}', '#{digested_password}');")
end

def list_user_by_name(name)
    record = run_sql("SELECT * FROM users WHERE name = '#{name}';")
    if record.count == 0
        return nil
    else
        return record[0]
    end
end

def update_user_by_id(id, name, password)
    digested_password = BCrypt::Password.create(password)
    run_sql("UPDATE users SET name = '#{name}', digested_password = '#{digested_password}' WHERE id = #{id};")
end

def delete_user_by_id(id)
    run_sql("DELETE FROM users WHERE id = #{id};")
end