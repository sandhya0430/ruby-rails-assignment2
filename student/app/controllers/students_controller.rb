class StudentsController < ApplicationController
     def publish_score
    student_id = params[:student_id]
    ScoreCalculatorWorker.perform_async(student_id)
    render json: { message: 'Score calculation is in progress' }, status: :ok
  end
  def fetch_scores_and_ranks
    # Assuming you have a Student model that has_many scores and ranks
    student_id = params[:student_id]
    student = Student.find_by(id: student_id)

    if student
      # Fetch scores and ranks for the given student
      scores = student.scores
      ranks = student.ranks

      render json: { scores: scores, ranks: ranks }, status: :ok
    else
      render json: { error: 'Student not found' }, status: :not_found
    end
  end
end
