class Rivendell::DB::Cart
  include DataMapper::Resource
  storage_names[:default] = 'CART'

  property :number, Integer, :key => true
  property :type, Integer, :default => 1, :required => true
  property :group_name, String, :length => 10, :required => true
  property :title, String, :required => true
  property :artist, String
  property :album, String
  property :year, Date

  property :average_length, Integer

  belongs_to :group, :child_key => [ :group_name ], :parent_key => [ :name ]
  has n, :cuts, :child_key => [ :cart_number ], :parent_key => [ :number ]

  before :valid?, :use_free_number

  def use_free_number(context = :default)
    self.number = group.free_cart_number if group
  end

  def self.duplicated(*fields)
    sql_fields = fields.join(", ")
    query = "select GROUP_CONCAT(NUMBER) as numbers, #{sql_fields} from CART group by #{sql_fields} having count(NUMBER) > 1;"

    repository(:default).adapter.select(query).map do |duplicated_group|
      field_values = fields.inject({}) { |map, field| map[field] = duplicated_group.send(field); map }
      numbers = duplicated_group.numbers.split(",").map(&:to_i)
      { :numbers => numbers, :fields => field_values }
    end
  end

  property :sched_codes, String

  def scheduler_codes
    if sched_codes
      sched_codes.scan(/.{11}/).map(&:strip)
    else
      []
    end
  end

  def scheduler_codes=(scheduler_codes)
    self.sched_codes =
      if scheduler_codes and !scheduler_codes.empty?
        scheduler_codes.uniq.sort.map { |c| c.ljust(11) }.join + "."
      else
        ""
      end
  end
end
