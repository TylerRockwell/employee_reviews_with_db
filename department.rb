require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:    'sqlite3',
  database:   'hr.sqlite3'
)

class Department < ActiveRecord::Base
  has_many :employees

  def add_employee(employee)
    employee.update(department_id: self.id)
  end

  def total_salary
    self.employees.sum(:salary)
  end

  def give_raise(total_amount)
    getting_raise = @employees.select {|e| e.satisfactory?}
    getting_raise.each {|e| e.give_raise(total_amount / getting_raise.length)}
  end
end
