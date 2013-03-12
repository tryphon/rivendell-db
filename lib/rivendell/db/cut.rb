class Rivendell::DB::Cut
  include DataMapper::Resource
  storage_names[:default] = 'CUTS'

  property :cut_name, String, :key => true
  property :last_play_datetime, Time

  belongs_to :cart, :child_key => [ :cart_number ], :parent_key => [ :number ]
end
