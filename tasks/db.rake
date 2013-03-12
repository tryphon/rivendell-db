namespace :db do

  def mysql_execute(database, command)
    system "echo \"#{command}\" | sudo -H mysql #{database}"
  end

  def mysql_load(database, file)
    system "sudo -H mysql #{database} < #{file}"
  end

  def mysql_admin(*args)
    system "sudo -H mysqladmin #{args.join(' ')}"
  end

  namespace :test do
    task :prepare => 'db:test:load'

    task :load => 'db:test:purge' do
      mysql_admin :create, 'rivendell_test'
      mysql_load 'rivendell_test', 'db/schema.sql'
      mysql_execute :mysql, "GRANT ALL PRIVILEGES ON rivendell_test.* TO 'rduser'@'localhost' IDENTIFIED BY 'letmein';"
      puts 'Database "rivendell_test" created'
    end

    task :purge do
      mysql_admin :drop, '--force rivendell_test'
    end
  end
end
