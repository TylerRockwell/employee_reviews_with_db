require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:    'sqlite3',
  database:   'hr.sqlite3'
)

class Employee < ActiveRecord::Base
  belongs_to :department
  has_many :reviews

  def recent_review
    reviews.last
  end

  def satisfactory?
    self.satisfactory
  end

  def give_raise(amount)
    self.update(salary: self.salary + amount)
  end

  def give_review(review)
    Review.create(employee_id: self.id, review: review)
    assess_performance
  end

  def assess_performance
    good_terms = [/positive/i, /good/i, /\b(en)?courag(e[sd]?|ing)\b/i, /ease/i, /improvement/i, /quick(ly)?/i, /incredibl[ey]/i, /\bimpress[edving]?{2,3}/i]
    bad_terms = [/\broom\bfor\bimprovement/i, /\boccur(ed)?\b/i, /not/i, /\bnegative\b/i, /less/i, /\bun[a-z]?{4,9}\b/i, /\b((inter)|e|(dis))?rupt[ivnge]{0,3}\b/i]
    good_terms = Regexp.union(good_terms)
    bad_terms = Regexp.union(bad_terms)

    recent_review = self.recent_review.review
    count_good = r_review.scan(good_terms).length
    count_bad = r_review.scan(bad_terms).length
    self.update(satisfactory: count_good - count_bad > 0)
  end

#   def find_palindrome_names
#     #Employee.where(name: name.downcase == name.reverse.downcase)
#     self.name.downcase.reverse == self.name.downcase
#   end
end
