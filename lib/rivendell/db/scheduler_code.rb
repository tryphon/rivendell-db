class Rivendell::DB::SchedulerCode
  include DataMapper::Resource
  storage_names[:default] = 'SCHED_CODES'

  property :code, String, :key => true
  property :description, String

  def carts
    Rivendell::DB::Cart.scheduler_code(code)
  end
end
