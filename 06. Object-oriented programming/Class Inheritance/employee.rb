require 'byebug'

class Employee
    attr_accessor :name, :salary, :title, :boss

    def initialize(name, salary, title, boss = nil)
        @name, @salary, @title, @boss = name, salary, title, boss
    end

    def bonus(multiplier)
        self.salary * multiplier
    end
end

class Manager < Employee
    attr_accessor :employees

    def initialize(name, salary, title, boss = nil)
        super(name, salary, title, boss)
        @employees = []
    end

    def add_employees(subordinate)
        self.employees.push(subordinate)
    end

    # Naive approach (peeling layer-by-layer) fine by me, but not as elegant as below...
    # def bonus(multiplier)
    #     total = 0
    #     # (total salary of all sub-employees) * multiplier
    #     self.employees.each do |employee|
    #        if employee.is_a?(Manager) 
    #             upper = employee
    #             total += upper.salary
    #             upper.employees.each { |emp| total += emp.salary }
    #        else
    #             total += employee.salary
    #        end
    #     end
    #     total * multiplier
    # end

    def bonus(multiplier)
        total_subsalary * multiplier
    end

    def total_subsalary
        total = 0

        self.employees.each do |employee|
            if employee.is_a?(Manager)
                total += employee.salary + employee.total_subsalary
            else
                total += employee.salary
            end
        end
        total
    end

end


ned = Manager.new("Ned", 1_000_000, "Founder")
darren = Manager.new("Darren", 78_000, "TA Manager", ned)
shawna = Employee.new("Shawna", 12_000, "TA", darren)
david = Employee.new("David", 10_000, "TA", darren)

ned.add_employees(darren)
# p ned.employees.map { |employee| employee.name }

darren.add_employees(shawna)
darren.add_employees(david)
# p darren.employees.map { |employee| employee.name }

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000