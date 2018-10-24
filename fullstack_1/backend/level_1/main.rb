
require 'json'

def computeProgress(target, start, value)
	return ((value - start) * 100 / (target - start).to_f).ceil
end

jsonFile = File.read('data/input.json')
inputData = JSON.parse(jsonFile)
objectives = inputData['objectives']
progressRecords = inputData['progress_records']

newRecords = []

progressRecords.each do |record|
	objectives.each do |objective|
		if record['objective_id'] == objective['id']
			progress = computeProgress(objective['target'], objective['start'], record['value'])
			newRecords << {id: record['id'], progress: progress}
		end
	end
end

newRecords = {progress_records: newRecords}
File.open('data/output.json', 'w') {|file| file.write(JSON.pretty_generate(newRecords))}