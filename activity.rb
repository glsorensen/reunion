class Activity
 	attr_reader :name,
              :participants,
              :total_cost

 	def initialize(name)
 		@name = name
    @participants = Hash.new(0)

 	end

  def add_participant(key,value)
    @participants[key] = value
  end

  def total_cost
    # @participants.map { |participant| participant[1] }.sum
    @participants.values.sum
  end

  def split
    @participants.values.sum / @participants.values.length
  end

  def owed
    @participants.transform_values {|value| split - value}
  end
end
