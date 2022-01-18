require './lib/activity'

RSpec.describe Activity do
  before(:each) do
 		@activity = Activity.new("Brunch")
 	end

 	it 'exists' do
 		expect(@activity).to be_a Activity
 	end

 	it 'has attributes' do
 		expect(@activity.name).to eq ("Brunch")
 	end

 	it 'can #add_participant' do
    @activity.add_participant("Maria", 20)

 		expect(@activity.participants).to eq ({"Maria" => 20})
 	end

 	it 'find #total_cost' do
    @activity.add_participant("Maria", 20)

 		expect(@activity.total_cost).to eq (20)
 	end

 	it 'can add more participants #add_participant' do
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)

 		expect(@activity.participants).to eq ({"Maria" => 20, "Luther" => 40})
 	end

 	it 'can find total cost with more participants' do
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)

 		expect(@activity.total_cost).to eq (60)
 	end

 	it 'can #split cost between participants' do
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)

 		expect(@activity.split).to eq (30)
 	end

 	it 'can subtract cost from each participant' do
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)

 		expect(@activity.owed).to eq ({"Maria" => 10, "Luther" => -10})
 	end
end
