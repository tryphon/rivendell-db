require 'dm-transactions'

# TODO make test DB configurable (Rakefile uses same parameters)
Rivendell::DB.establish_connection 'mysql://rduser:letmein@localhost/rivendell_test'

RSpec.configure do |config|
  config.before(:each) do
    repository(:default) do
      transaction = DataMapper::Transaction.new(repository)
      transaction.begin
      repository.adapter.push_transaction(transaction)
    end
  end
  
  config.after(:each) do
    repository(:default).adapter.pop_transaction.rollback
  end
end
