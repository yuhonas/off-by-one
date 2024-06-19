class CreateStudentTestResults < ActiveRecord::Migration[7.1]
  def change
    create_table :student_test_results do |t|
      # NOTE: We have no guarantee that the student number or test_id is unique or numeric
      t.column :student_number, :string, null: false
      t.column :test_id, :string, null: false

      # NOTE: The calculations on these could be cached in counter columns or
      # an alternative method depending on how often they are accessed
      # we will also never perform a full table scan on these columns as "at present"
      # a subset by test_id which is indexed will be used

      t.column :marks_available, :float, null: false
      t.column :marks_obtained, :float, null: false
      t.column :scanned_on, :datetime

      # NOTE: There is an xml data type in postgres, but we are using text as
      # there the potential for the xml to be malformed causing the parser to fail
      # text columns have an upper limit of 1GB, which should be more than enough
      # we need the original data persisted for replayability and auditing as we learn more
      t.column :xml_data, :text

      # NOTE: This composite index will be used to find the student results for a test,
      # we could enforce a unique constraint on this
      t.index %i[student_number test_id]

      # NOTE: For reporting we will need to find all the results for a test
      t.index :test_id

      t.timestamps
    end
  end
end
