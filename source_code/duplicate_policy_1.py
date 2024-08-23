import sys
def readfile_contents (file):
	fp = open(file,"r")
	raw_data = fp.read()
	fp.close()
	return raw_data
# Process raw file content
def process_blob (csv_blob):
	csv_blob = csv_blob.split('\n')
	hash_table = {}
	row_id = 1
	duplicates = 0
	for line in csv_blob[1:]:
		# split line by comma
		row = line.split(',')	
		# skip empty rows
		if len(row) < 16:
			continue
		# Use the first 17 columns
		first_seventeen_key = ''.join(row[0:17])
		#print(first_seventeen_key)
		# Get show data
		show_data = row[17]
		#print(show_data)
		# Create a new tuple of the rowId and the show data
		new_dup = (row_id+1, show_data)
		# Use the key to define the dictionary
		if first_seventeen_key in hash_table:
			if new_dup not in hash_table[first_seventeen_key]:
				hash_table[first_seventeen_key].append(new_dup)
				duplicates += 1
		else:
			# Create a list of lists for the provided key
			hash_table[first_seventeen_key] = []
			hash_table[first_seventeen_key].append(new_dup)		
		# increment row_id
		row_id = row_id + 1
	#print duplicates
	return hash_table
def clean_data(hash_table):
	# list of rows to remove
	remove_list = []
	# Deleted
	deleted = 0
	for key,value in hash_table.iteritems():
		# if duplicates is equal to 1 ignore
		if len(value) == 1:
			continue
		#print(key)	
		# Process yes and no values for show
		duplicate_yes = 0
		duplicate_no = 0		
		# Process duplicate values for yes and no
		for duplicate in value:
			if duplicate[1] == 'Y':
				duplicate_yes += 1
			else:
				duplicate_no += 1
		
		# Cases
		if duplicate_no == 0 or duplicate_yes == 0:
			continue
	
		elif duplicate_yes == duplicate_no:
			# remove all
			for duplicate in value:
				remove_list.append(duplicate)
				deleted += 1
		
		elif duplicate_yes > duplicate_no:
			# Only keep 1 yes
			found_yes = False
			# remove all no
			for duplicate in value:
				if duplicate[1] == 'N':
					remove_list.append(duplicate)
					deleted += 1

				elif found_yes == False:
					found_yes = True
				else:
					remove_list.append(duplicate)
					deleted += 1

		elif duplicate_yes < duplicate_no:
			# only keep 1 no
			found_no = False
			# remove all yes
			for duplicate in value:
				if duplicate[1] == 'Y':
					remove_list.append(duplicate)
					deleted += 1
				elif found_no == False:
					found_no = True
				else:
					remove_list.append(duplicate)
					deleted += 1
	#print deleted
	return remove_list

def with_duplicates(csv_blob,hash_table,remove_list=[]):
	csv_blob = csv_blob.split('\n')
	row_id = 2
	# add the header into the processed_csv
	processed_csv = [csv_blob[0]]
	for line in csv_blob[1:]:
		# split data by comma
		row = line.split(',')		
		# skip empty row
		if len(row) < 17:
			continue

		# generate the key
		first_seventeen_key = ''.join(row[0:17])	
		
		# remove duplicates based on tuple in remove_list				
		if len(remove_list)>0:
			# show value
			show_value = row[17]
			
			# create tuple for row
			item_duple = (row_id, show_value)
			
			# add if not found in remove_list
			if item_duple not in remove_list:
				processed_csv.append(line)			
		
		# Check the first tuple in the list of tuples for row_id
		elif hash_table[first_seventeen_key][0][0] == row_id:
			duplicate_list = [x for x in hash_table[first_seventeen_key][1:]]

			# create the new updated line
			updated_line = '%s,%s'%(line, duplicate_list)
		
			# insert it into the processed_csv list
			processed_csv.append(updated_line)
		else:
			# add the line otherwise
			processed_csv.append(line)

		# increment row
		row_id += 1

	return '\n'.join(processed_csv)

def get_duplicate_keys(key_file):
	# get raw keys	
	key_raw = readfile_contents(key_file)
	# split keys
	keys = key_raw.split('\n')
	return keys
	
		
if __name__ == "__main__":
	# Read in the file to process
	csv_file = sys.argv[1]
	duplicates = sys.argv[2]
	#duplicate_key_file = sys.argv[3]
	# Read in the contents of the file
	file_contents = readfile_contents(csv_file)
	# Process CSV file
	hash_table = process_blob(file_contents)	
	# Get remove list
	#duplicate_keys = get_duplicate_keys(duplicate_key_file)
	remove_list = clean_data(hash_table)
	
	# Print duplicates CSV file
	if duplicates == 'show':
		print(with_duplicates(file_contents, hash_table))
	else:		
		print(with_duplicates(file_contents, hash_table, remove_list))
