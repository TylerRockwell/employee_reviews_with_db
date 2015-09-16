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
    employees.sum(:salary)
  end

  def give_raise(total_amount)
    getting_raise = employees.select {|e| e.satisfactory?}
    getting_raise.each {|e| e.give_raise(total_amount / getting_raise.length)}
  end

  def number_of_employees
    employees.where(department_id: self.id).count(:id)
  end
end
