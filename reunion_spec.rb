require './lib/reunion'
require './lib/activity'

RSpec.describe Reunion do
	before(:each) do
		@reunion = Reunion.new("1406 BE")
    @activity_1 = Activity.new("Brunch")
    @activity_2 = Activity.new("Drinks")
    @activity_3 = Activity.new("Bowling")
    @activity_4 = Activity.new("Jet Skiing")

    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @activity_3.add_participant("Maria", 0)
    @activity_3.add_participant("Luther", 0)
    @activity_3.add_participant("Louis", 30)
    @activity_4.add_participant("Maria", 0)
    @activity_4.add_participant("Luther", 0)
    @activity_4.add_participant("Louis", 40)
    @activity_4.add_participant("Nemo", 40)

	end

	it 'exists' do
		expect(@reunion).to be_a Reunion
	end

	it 'has attributes' do
		expect(@reunion.name).to eq ("1406 BE")
	end

	it 'has attributes' do
		expect(@reunion.activities).to eq ([])
	end

	it 'can #add_activity' do
    @reunion.add_activity(@activity_1)

		expect(@reunion.activities).to eq ([@activity_1])
	end

	it 'find total cost' do
    @reunion.add_activity(@activity_1)

		expect(@reunion.total_cost).to eq (60)
	end

  it 'find total cost' do
    @reunion.add_activity(@activity_1)
    @reunion.add_activity(@activity_2)

		expect(@reunion.total_cost).to eq (180)
	end

  it 'price breakdown' do
    @reunion.add_activity(@activity_1)
    @reunion.add_activity(@activity_2)

    expected = {
      "Maria" => -10,
      "Luther" => -30,
      "Louis" => 40
    }

		expect(@reunion.breakdown).to eq (expected)
	end

  it 'makes price breakdown easy to read' do
    @reunion.add_activity(@activity_1)
    @reunion.add_activity(@activity_2)

    expected = "Maria: -10\nLuther: -30\nLouis: 40"

		expect(@reunion.summary).to eq (expected)
  end

  it 'gives a detailed breakdown' do
    @reunion.add_activity(@activity_1)
    @reunion.add_activity(@activity_2)
    @reunion.add_activity(@activity_3)
    @reunion.add_activity(@activity_4)

    expected = {
      "Maria" => [
        {
          activity: "Brunch",
          payees: ["Luther"],
          amount: 10
        },
        {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
        },
        {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
        },
        {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Luther" => [
        {
          activity: "Brunch",
          payees: ["Maria"],
          amount: -10
        },
        {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
        },
        {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
        },
        {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Louis" => [
        {
          activity: "Drinks",
          payees: ["Maria", "Luther"],
          amount: 20
        },
        {
          activity: "Bowling",
          payees: ["Maria", "Luther"],
          amount: -10
        },
        {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ],
      "Nemo" => [
        {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ]
    }

		expect(@reunion.detailed_breakdown).to eq (expected)
  end
end
