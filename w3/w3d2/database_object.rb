require_relative 'requirements'
require 'byebug'
class DatabaseObject

  attr_accessor :rel_table

  def save
    if @id
      update_self
    else
      insert_self
    end
  end

  def insert_self
    as_hash = {}
    self.instance_variables.each do |var|
      unless [:@id, :@rel_table].include?(var)
        as_hash[var.to_s[1..-1]] = self.send(var.to_s[1..-1].to_sym)
      end
    end

    insert_string_arr = []
    as_hash.keys.each do |key|
      insert_string_arr << key.to_s
    end
    insert_string = "#{@rel_table} (" + insert_string_arr.join(", ") + ")"
    QuestionsDatabase.instance.execute(<<-SQL, *as_hash.values)
     INSERT INTO
        #{insert_string}
     VALUES
        (#{(["?"]*as_hash.values.length).join(", ")})
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end


  def update_self

    as_hash = {}
    self.instance_variables.each do |var|
      unless [:@id, :@rel_table].include?(var)
        as_hash[var.to_s[1..-1]] = self.send(var.to_s[1..-1].to_sym)
      end
    end

    col_names = as_hash.keys
    name_and_q_mark = col_names.zip([" = ?"]*col_names.length)
    name_equals_q_mark = name_and_q_mark.map { |col, eql| col+eql}

    QuestionsDatabase.instance.execute(<<-SQL, *as_hash.values)
     UPDATE
      #{@rel_table}
     SET
     #{ name_equals_q_mark.join(", \n") }
     WHERE
      id = #{@id}
    SQL
  end

  def self.find_by_id(id, rel_table, class_string)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{rel_table}
      WHERE
        id = ?
    SQL
    class_string.new(results.first)
  end


end
