
require 'date'
require 'json'

def computeExpectedCompletion(sDate, eDate, cDate, target, start)
	return ((target - start) * (cDate - sDate)) / (eDate - sDate)
end

def computeExcess(eProgress, start, value)
	res = ((value - start - eProgress) * 100 / eProgress)
	if res >= 0
		return res.ceil
	else
		return res.floor
	end
end

jsonFile = File.read('data/input.json')
inputData = JSON.parse(jsonFile)
objectives = inputData['objectives']
progressRecords = inputData['progress_records']

newRecords = []

progressRecords.each do |record|
	objectives.each do |objective|
		if record['objective_id'] == objective['id']
			startDate = DateTime.parse(objective['start_date'])
			endDate = DateTime.parse(objective['end_date'])
			currentDate = DateTime.parse(record['date'])
			expectedProgress = computeExpectedCompletion(startDate, endDate, currentDate, objective['target'], objective['start'])
			exess = computeExcess(expectedProgress, objective['start'], record['value'])
			newRecords << {id: record['id'], excess: exess}
		end
	end
end

newRecords = {progress_records: newRecords}
File.open('data/output.json', 'w') {|file| file.write(JSON.pretty_generate(newRecords))}