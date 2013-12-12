class Rivendell::DB::Cut
  include DataMapper::Resource
  storage_names[:default] = 'CUTS'

  belongs_to :cart, :child_key => [ :cart_number ], :parent_key => [ :number ]

  property :cut_name, String, :key => true
  property :last_play_datetime, Time

  property :start_datetime, Time
  property :end_datetime, Time

  property :start_daypart, String
  property :end_daypart, String

  @@days = %w{sun mon tue wed thu fri sat}.freeze
  def self.days
    @@days
  end

  days.each do |day|
    property day, Enum['N','Y'],  :default => 'Y'
  end

  def enable_on?(day)
    send(day) == 'Y'
  end

  def enable_on(day, enabled = true)
    send("#{day}=", enabled ? 'Y' : 'N')
  end

  def days
    self.class.days.select do |day|
      enable_on? day
    end
  end

  def days=(days)
    self.class.days.each do |day|
      enable_on day, days.include?(day)
    end
  end

end
