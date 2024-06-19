class CreateStudentTestResultSets < ActiveRecord::Migration[7.1]
  def change
    create_table :student_test_result_sets do |t|
      # NOTE: Not necesary but could be useful for debugging/request tracing
      # or support
      t.string :request_id, null: false

      # NOTE: There is an xml data type in postgres, but we are using text as
      # there the potential for the xml to be malformed causing the parser to fail
      # text columns have an upper limit of 1GB, which should be more than enough
      # we need the original data persisted for replayability and auditing as we learn more
      t.column :xml_data, :text, null: false

      t.timestamps
    end

    remove_column :student_test_results, :xml_data, :text
    add_belongs_to :student_test_results, :student_test_result_set, foreign_key: true
  end
end
