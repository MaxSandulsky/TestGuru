class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_set_next_question

  scope :by_uncomplete, -> { where.not(current_question: nil).order(id: :desc) }

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def test_passage_result
    correct_questions * 100 / test.questions.count
  end

  def result_color
    test_passage_result > 85 ? 'green' : 'red'
  end

  def result_text
    test_passage_result > 85 ? 'Success' : 'Failure'
  end

  def completeness
    question_ids = test.questions.pluck(:id)
    "#{question_ids.index(current_question.id)}/#{question_ids.count}"
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_update_set_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def correct_answer?(answer_ids)
    return false if answer_ids.nil?

    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end
end